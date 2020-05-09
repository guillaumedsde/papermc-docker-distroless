# PaperMC Minecraft Server distroless docker container

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
    guillaumedsde/papermc:latest
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
        image: guillaumedsde/papermc:latest
```

## TODO

- Run as non-root user (Docker volumes do not support this yet)
