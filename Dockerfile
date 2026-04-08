FROM debian:trixie-slim AS builder

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
	apt-get upgrade -y --no-install-recommends && \
	apt-get install -y --no-install-recommends curl unzip zip git libatomic1 ca-certificates golang fakeroot dpkg-dev && \
	apt-get clean && \
	rm -rf /var/cache/apt/* && \
	rm -rf /var/lib/apt/lists/*

RUN go install github.com/asdf-vm/asdf/cmd/asdf@v0.18.1

ENV PATH="/root/go/bin:$PATH"
ENV ASDF_DATA_DIR="/root/.asdf"

RUN mkdir -p $ASDF_DATA_DIR/plugins $ASDF_DATA_DIR/installs $ASDF_DATA_DIR/shims

RUN asdf plugin add nodejs
RUN asdf install nodejs latest
RUN asdf set --home nodejs latest

RUN asdf plugin add java
RUN asdf install java latest:openjdk-26
RUN asdf set --home java latest:openjdk-26

RUN asdf plugin add gradle
RUN asdf install gradle latest:9
RUN asdf set --home gradle latest:9

FROM debian:trixie-slim

RUN apt-get update && \
	apt-get upgrade -y --no-install-recommends && \
	apt-get install -y --no-install-recommends curl unzip zip git libatomic1 ca-certificates golang fakeroot dpkg-dev && \
	apt-get clean && \
	rm -rf /var/cache/apt/* && \
	rm -rf /var/lib/apt/lists/*

COPY --from=builder /root/.asdf        /root/.asdf
COPY --from=builder /root/go/bin/asdf  /root/.asdf/bin/asdf

ENV PATH="/root/.asdf/shims:/root/.asdf/bin:$PATH"

LABEL org.opencontainers.image.title="debian-builder"
LABEL org.opencontainers.image.description="Build environment for Vue 3 + Spring Boot (Java 26) + Gradle stack applications"
LABEL org.opencontainers.image.version="1.0.0"
LABEL org.opencontainers.image.licenses="MIT"