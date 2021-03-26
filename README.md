# gitsync-docker

[![Docker Image CI](https://github.com/edijon/gitsync-docker/actions/workflows/docker-image.yml/badge.svg)](https://github.com/edijon/gitsync-docker/actions/workflows/docker-image.yml)

* Docker image builder for gitsync project.
    > `gitsync` : https://github.com/edijon/gitsync
* You are free to use it on your own risk.

## Usage

* Get help
    ```bash
    make help
    ```
* Build image
    ```bash
    make build
    ```

## gitsync docker CLI (optional)

* Once gitsync docker image is set up, get help :
    ```bash
    docker run -it --rm gitsync:latest
    ```