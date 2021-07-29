FROM debian:buster-slim


ARG GHCUP_BIN_DIR=/root/.ghcup/bin
# /root happens to be $HOME but we can't use the directly in an ARG
RUN \
  mkdir -p ${GHCUP_BIN_DIR}


ARG PATH
ENV PATH=${PATH}:${GHCUP_BIN_DIR}
ENV LANG=C.UTF-8
ENV BOOTSTRAP_HASKELL_NONINTERACTIVE=1


RUN \
  apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    freetds-dev \
    g++ \
    gcc \
    git \
    gnupg2 \
    libc-dev \
    libghc-pcre-light-dev \
    libghc-hsopenssl-dev \
    libgmp-dev \
    libgssapi-krb5-2 \
    libkrb5-dev \
    locales \
    make


RUN \
  locale-gen en_US.UTF-8


ARG GHCUP_DWN_URL=https://downloads.haskell.org/~ghcup/x86_64-linux-ghcup
RUN \
	curl -sSL ${GHCUP_DWN_URL} > ${GHCUP_BIN_DIR}/ghcup && \
	chmod +x ${GHCUP_BIN_DIR}/ghcup


ARG GHC_VERSION=9.0.1
RUN \
  ghcup upgrade && \
  ghcup install cabal && \
  ghcup install ghc ${GHC_VERSION} && \
  ghcup set ghc ${GHC_VERSION} && \
  ghcup install hls && \
  cabal update


# docker run --rm -it --name ghcup -v `pwd`:/workdir -w /workdir ghcup bash
