# Poetry Docker

trying out multi stage builds with pytest in base stage.  The app doesn't really matter, in this case it takes a list of arguments and sums them.

## Docker file

The Dockerfile is broken into 3 sections, build, test, and runtime

Build creates the wheel
Test installs pytest and the wheel and tests it
Runtime creates an entrypoint in a slimmed down image
