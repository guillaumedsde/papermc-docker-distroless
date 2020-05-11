# PaperMC Minecraft Server distroless docker container

[![Gitlab pipeline status](https://img.shields.io/gitlab/pipeline/guillaumedsde/papermc-docker-distroless?label=docker%20build)](https://gitlab.com/guillaumedsde/papermc-docker-distroless/pipelines)
[![Docker Automated build](https://img.shields.io/docker/cloud/automated/guillaumedsde/papermc-docker-distroless)](https://hub.docker.com/r/guillaumedsde/papermc-docker-distroless/)
[![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/guillaumedsde/papermc-docker-distroless/latest)](https://hub.docker.com/r/guillaumedsde/papermc-docker-distroless/builds)
[![Docker Pulls](https://img.shields.io/docker/pulls/guillaumedsde/papermc-docker-distroless)](https://hub.docker.com/r/guillaumedsde/papermc-docker-distroless/)
[![Docker Stars](https://img.shields.io/docker/stars/guillaumedsde/papermc-docker-distroless)](https://hub.docker.com/r/guillaumedsde/papermc-docker-distroless/)
[![GitHub stars](https://img.shields.io/github/stars/guillaumedsde/papermc-docker-distroless)](https://github.com/guillaumedsde/papermc-docker-distroless)

This is a docker container running the [Paper Minecraft Server](https://github.com/PaperMC/Paper) and based off [Google's distroless](https://github.com/GoogleContainerTools/distroless) Java container, making it lighter and more secure.

PaperMC runs with [aikar's optimized flags](https://mcflags.emc.gs) in order to try and improve the performance.

## How to run

Launch the container, this will create the PaperMC directory in your current directory

*optional: set `-Xms2G -Xmx2G` to the Amount of RAM to allocate to PaperMC*

### `docker run`

```bash
$ docker run \
    -v $(pwd)/papermc:/papermc \
    -e JAVA_TOOL_OPTIONS="-Xms2G -Xmx2G" \
    -p 25565:25565 \
    guillaumedsde/papermc-docker-distroless:latest
```


### `docker-compose`

```yaml
version: '3.3'
services:
    papermc:
        volumes:
            - '<data_dir>/papermc:/papermc'
        environment:
            - 'JAVA_TOOL_OPTIONS=-Xms2G -Xmx2G'
        ports:
            - '25565:25565'
        image: guillaumedsde/papermc-docker-distroless:latest
```

## TODO

- Run as non-root user (Docker volumes do not support this yet)
