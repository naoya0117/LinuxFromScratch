# vim: set filetype=dockerfile :
FROM docker.io/library/fedora:42

LABEL org.opencontainers.image.source=https://github.com/naoya0117/linux-from-scratch
LABEL org.opencontainers.image.description="Linux From Scratchを構築するためのfedoraベースのDockerイメージ"
LABEL org.opencontainers.image.licenses=MIT

ARG UID=1000
ARG GID=1000

RUN getent group ${GID} || groupadd -g ${GID} nonroot && \
  getent passwd ${UID} || useradd -u ${UID} -g ${GID} -m -s /bin/bash nonroot

ENV NODE_VERSION=22

RUN dnf install -y curl gnupg2 dnf-plugins-core && \
  curl -fsSL https://rpm.nodesource.com/setup_${NODE_VERSION}.x | bash - && \
  # node:${NODE_VERSION}のインストール
  dnf install -y nodejs && \
  dnf clean all && \
  rm -rf /var/cache/dnf

CMD ["node"]

# 非特権ユーザを作成
USER nonroot

WORKDIR /workdir
