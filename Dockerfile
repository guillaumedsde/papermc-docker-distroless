# Distroless Java base
FROM gcr.io/distroless/java:11

# PaperMC version
ARG PAPERMC_VERSION=1.15.2

# PaperMC build number
ARG PAPERMC_BUILD=267

# PaperMC
# ENV JAVA_TOOL_OPTIONS=""
# ENV PAPER_MC_PORT=25565
# ENV PAPER_MC_SERVER_NAME=papermc
# ENV PAPER_MC_ONLINE_MODE=true
# ENV PAPER_MC_WORLD_DIR=/papermc/worlds

# Download PaperMC binary and set ownership to non-root user's UID
# ADD --chown=65532:65532 https://papermc.io/api/v1/paper/${PAPERMC_VERSION}/${PAPERMC_BUILD}/download /papermc.jar
ADD --chown=65532:65532 ./paper-267.jar /papermc.jar

# Switch main directory
COPY --chown=65532:65532 papermc /papermc
COPY --chown=65532:65532 worlds ${PAPER_MC_WORLD_DIR}

# switch to non-root user
# USER nonroot

WORKDIR /papermc

ENTRYPOINT [ "java", "-jar", "/papermc.jar" ]

# start container with PaperMC
# CMD ["", "--port", "${PAPER_MC_PORT}", "--online-mode ${PAPER_MC_ONLINE_MODE}", "--world ${PAPER_MC_WORLD_DIR}","--server-name ${PAPER_MC_SERVER_NAME}", "--nogui"]