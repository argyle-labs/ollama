# TODO: base image + build for ollama. Mirror jellyfin/Dockerfile conventions.
FROM debian:12-slim
LABEL org.opencontainers.image.source="https://github.com/argyle-labs/ollama"
EXPOSE 11434
