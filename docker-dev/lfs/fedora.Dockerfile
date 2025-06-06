# vim: set filetype=dockerfile :
FROM docker.io/library/fedora:42

# ghcr.ioと連携するためのラベル
LABEL org.opencontainers.image.source=https://github.com/naoya0117/linux-from-scratch
LABEL org.opencontainers.image.description="Linux From Scratchを構築するためのfedoraベースのDockerイメージ"
LABEL org.opencontainers.image.licenses=MIT

# 非特権ユーザのGID, UID(ホストユーザと合わせる)
ARG UID=1000
ARG GID=1000

ARG USERNAME=lfs

# 非特権ユーザとグループの作成
RUN getent group ${GID} || groupadd -g ${GID} ${USERNAME} && \
  getent passwd ${UID} || useradd -u ${UID} -g ${GID} -m -s /bin/bash ${USERNAME} && \
  # sudoを無認証で利用できるようにする
  echo "${USERNAME} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/99-nopassword-${USERNAME} && \
  chmod 0440 /etc/sudoers.d/99-nopassword-${USERNAME}


# インストールするNode.jsのバージョン
ENV NODE_VERSION=22
ENV LFS=/mnt/lfs

RUN dnf install -y \
  # 環境構築に必要なパッケージ
  curl gnupg2 dnf-plugins-core && \
  # リポジトリの追加(nodejs)
  curl -fsSL https://rpm.nodesource.com/setup_${NODE_VERSION}.x | bash - && \
  # lfsの開発に必要なパッケージ(ドキュメント記載)
  dnf group install -y development-tools && \
  dnf install -y \
  # lfsの開発に必要なパッケージ(ドキュメント記載)
  gawk texinfo \
  # version_check.shによって不足を検出したパッケージ
  binutils bison gcc gcc-c++ m4 make patch perl texinfo-tex \
  # chapterで新たに必要になったパッケージ
  iputils wget python3-devel \
  # 任意ツール(node)
  nodejs && \
  ln -sfn /usr/bin/bison /usr/bin/yacc && \
  # キャッシュの削除
  dnf clean all && \
  rm -rf /var/cache/dnf

# 非特権ユーザを作成
USER $USERNAME

# 作業ディレクトリ
WORKDIR $LFS
