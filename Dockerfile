FROM debian:trixie-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
	apt-get upgrade -y --no-install-recommends && \
	apt-get install -y --no-install-recommends curl unzip zip git libatomic1 ca-certificates golang fakeroot dpkg-dev && \
	apt-get clean && \
	rm -rf /var/cache/apt/* && \
	rm -rf /var/lib/apt/lists/*

ENV PATH="/root/go/bin:$PATH"
ENV ASDF_DATA_DIR="/root/.asdf"

RUN mkdir -p $ASDF_DATA_DIR/plugins $ASDF_DATA_DIR/installs $ASDF_DATA_DIR/shims

RUN go install github.com/asdf-vm/asdf/cmd/asdf@v0.18.0 && \
	asdf plugin add nodejs && \
	asdf install nodejs latest && \
	asdf set --home nodejs latest && \
	asdf plugin add java && \
	asdf install java latest:openjdk && \
	asdf set --home java latest:openjdk && \
	asdf plugin add gradle && \
	asdf install gradle latest:9 && \
	asdf set --home gradle latest:9 && \
	rm -rf $ASDF_DATA_DIR/downloads/* && \
	rm -rf $ASDF_DATA_DIR/tmp/* && \
	rm -rf /root/.cache/* && \
	rm -rf /root/go/pkg/* && \
	rm -rf /tmp/* && \
	rm -rf /var/tmp/*

ENV PATH="/root/.asdf/shims:$PATH"

LABEL org.opencontainers.image.title="debian-builder"
LABEL org.opencontainers.image.description="Build environment for Vue 3 + Spring Boot (Java 25) + Gradle stack applications"
LABEL org.opencontainers.image.version="1.0.0"
LABEL org.opencontainers.image.licenses="MIT"