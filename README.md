# PaperMC Minecraft Server distroless docker container

This is a docker container running the [Paper Minecraft Server](https://github.com/PaperMC/Paper) and based off [Google's distroless](https://github.com/GoogleContainerTools/distroless) Java container, making it lighter and more secure.

## How to run

Launch the container (this will create the PaperMC directory in your current directory, change as you wish):

```bash
$ docker run \
    -v $(pwd)/papermc:/papermc \
    -p 25565:25565 \
    guillaumedsde/papermc
```

Stop the container (`CTRL+C`), accept the EULA in `eula.txt`:

```bash
sed -i 's/eula=false/eula=true/g' ./papermc/eula.txt
```

Restart the container with the first command

## TODO

- Run as non-root user (Docker volumes do not support this yet)
