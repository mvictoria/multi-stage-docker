# The builder image, used to build the virtual environment
FROM python:3.12 as builder

RUN pip install uv

RUN uv pip install --system poetry==1.8.3

ENV POETRY_NO_INTERACTION=1 \
    POETRY_VIRTUALENVS_IN_PROJECT=1 \
    POETRY_VIRTUALENVS_CREATE=1 \
    POETRY_CACHE_DIR=/tmp/poetry_cache

COPY pyproject.toml poetry.lock ./
RUN touch README.md

COPY ./app ./app
RUN poetry build


# a new docker image to test - not necessary, does it help anything?
FROM builder as test

RUN uv pip install --system pytest
RUN uv pip install --system ./dist/app-0.1.0-py3-none-any.whl

COPY ./tests ./tests
RUN pytest ./tests


# create actual runtime image
FROM python:3.12-slim as runtime

COPY --from=builder ./dist ./dist

RUN pip install ./dist/app-0.1.0-py3-none-any.whl

RUN groupadd -g 1001 python_application && \
    useradd -r -u 1001 -g python_application python_application

USER 1001

ENTRYPOINT [ "my-script" ]
CMD ["my-script",""]