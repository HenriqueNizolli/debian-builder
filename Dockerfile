FROM debian:trixie-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update
RUN apt-get upgrade -y --no-install-recommends
RUN apt-get install -y --no-install-recommends curl unzip zip git libatomic1 ca-certificates golang fakeroot dpkg-dev
RUN apt-get clean

RUN go install github.com/asdf-vm/asdf/cmd/asdf@v0.18.0

ENV PATH="/root/go/bin:$PATH"
ENV ASDF_DATA_DIR="/root/.asdf"

RUN mkdir -p $ASDF_DATA_DIR/plugins $ASDF_DATA_DIR/installs $ASDF_DATA_DIR/shims

RUN asdf plugin add nodejs
RUN asdf install nodejs latest
RUN asdf set --home nodejs latest

RUN asdf plugin add java
RUN asdf install java latest:openjdk-25
RUN asdf set --home java latest:openjdk-25

RUN asdf plugin add gradle
RUN asdf install gradle latest:9
RUN asdf set --home gradle latest:9

RUN rm -rf $ASDF_DATA_DIR/downloads/*
RUN rm -rf $ASDF_DATA_DIR/tmp/*
RUN rm -rf /root/.cache/*
RUN rm -rf /root/go/pkg/*
RUN rm -rf /tmp/*
RUN rm -rf /var/tmp/*
RUN rm -rf /var/cache/apt/*
RUN rm -rf /var/lib/apt/lists/*

ENV PATH="/root/.asdf/shims:$PATH"

LABEL org.opencontainers.image.title="debian-builder"
LABEL org.opencontainers.image.description="Build environment for Vue 3 + Spring Boot (Java 25) + Gradle stack applications"
LABEL org.opencontainers.image.version="1.0.0"
LABEL org.opencontainers.image.licenses="MIT"