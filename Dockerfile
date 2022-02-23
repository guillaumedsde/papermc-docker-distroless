# Distroless Java base
FROM gcr.io/distroless/java17

VOLUME [ "/papermc" ]

# Switch to main directory
WORKDIR /papermc

# PaperMC version
ARG PAPERMC_VERSION=1.18.1

# PaperMC build number
ARG PAPERMC_BUILD=214

# Download PaperMC binary and set ownership to non-root user's UID
# Download API v2 format: https://papermc.io/api/v2/projects/{PROJECT}/versions/{VERSION}/builds/{BUILD}/downloads/{DOWNLOAD}
# There is not "latest" - you have to pull the latest build number from the REST API
# E.g.: https://papermc.io/api/v2/projects/paper/versions/1.18.1/builds/214/downloads/paper-mojmap-1.18.1-214.jar
ADD --chown=65532:65532 https://papermc.io/api/v2/projects/paper/versions/${PAPERMC_VERSION}/builds/${PAPERMC_BUILD}/downloads/paper-mojmap-${PAPERMC_VERSION}-${PAPERMC_BUILD}.jar /papermc.jar

# switch to non-root user
USER nonroot

## Expose PaperMC ports
EXPOSE 25565/tcp
EXPOSE 25565/udp

# start container with PaperMC as entrypoint
# with optimized flags from https://mcflags.emc.gs
ENTRYPOINT ["java", "-XX:+UseG1GC", "-XX:+ParallelRefProcEnabled", "-XX:MaxGCPauseMillis=200", "-XX:+UnlockExperimentalVMOptions", "-XX:+DisableExplicitGC", "-XX:+AlwaysPreTouch", "-XX:G1NewSizePercent=30", "-XX:G1MaxNewSizePercent=40", "-XX:G1HeapRegionSize=8M", "-XX:G1ReservePercent=20", "-XX:G1HeapWastePercent=5", "-XX:G1MixedGCCountTarget=4", "-XX:InitiatingHeapOccupancyPercent=15", "-XX:G1MixedGCLiveThresholdPercent=90", "-XX:G1RSetUpdatingPauseTimePercent=5", "-XX:SurvivorRatio=32", "-XX:+PerfDisableSharedMem", "-XX:MaxTenuringThreshold=1", "-Dusing.aikars.flags=https://mcflags.emc.gs", "-Daikars.new.flags=true", "-Dcom.mojang.eula.agree=true", "-jar", "/papermc.jar", "--nogui", "--nojline"]
