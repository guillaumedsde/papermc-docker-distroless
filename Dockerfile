# Distroless Java base
FROM gcr.io/distroless/java:11

# PaperMC version
ARG PAPERMC_VERSION=1.15.2

# PaperMC build number
ARG PAPERMC_BUILD=latest

# PaperMC
# ENV JAVA_TOOL_OPTIONS=""
# ENV PAPER_MC_PORT=25565
# ENV PAPER_MC_SERVER_NAME=papermc
# ENV PAPER_MC_ONLINE_MODE=true
# ENV PAPER_MC_WORLD_DIR=/papermc/worlds
ENV PAPER_MC_RAM=2G

# Download PaperMC binary and set ownership to non-root user's UID
ADD --chown=65532:65532 https://papermc.io/api/v1/paper/${PAPERMC_VERSION}/${PAPERMC_BUILD}/download /papermc.jar

# Switch main directory
COPY --chown=65532:65532 papermc /papermc

# switch to non-root user
# USER nonroot

WORKDIR /papermc

# Expose PaperMC ports
EXPOSE 25565/tcp
EXPOSE 25565/udp

ENTRYPOINT java -Xms$PAPER_MC_RAM -Xmx$PAPER_MC_RAM -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -Dcom.mojang.eula.agree=true -jar /papermc.jar --nogui --nojline

# start container with PaperMC
# CMD ["", "--port", "${PAPER_MC_PORT}", "--online-mode ${PAPER_MC_ONLINE_MODE}", "--world ${PAPER_MC_WORLD_DIR}","--server-name ${PAPER_MC_SERVER_NAME}", "--nogui"]