# The builder image, used to build the virtual environment
FROM python:3.12-alpine as base
RUN apk update && apk upgrade && rm /var/cache/apk/*
RUN python3 -m pip install --upgrade pip


#-------------------------------------------------------------------------------
FROM base as builder

RUN pip install uv && uv pip install --system poetry==1.8.3

ENV POETRY_NO_INTERACTION=1 \
    POETRY_VIRTUALENVS_IN_PROJECT=1 \
    POETRY_VIRTUALENVS_CREATE=1 \
    POETRY_CACHE_DIR=/tmp/poetry_cache

COPY pyproject.toml poetry.lock ./
RUN touch README.md

COPY ./app ./app
RUN poetry build


#-------------------------------------------------------------------------------
# run tests
RUN uv pip install --system pytest ./dist/*.whl

COPY ./tests ./tests
RUN pytest ./tests


#-------------------------------------------------------------------------------
# create actual runtime image
FROM base as runtime

COPY --from=builder ./dist ./dist

RUN pip install ./dist/*.whl

# create app user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

USER appuser

ENTRYPOINT [ "my-script" ]
CMD ["my-script",""]