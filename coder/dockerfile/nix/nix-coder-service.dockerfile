FROM coderenvs/coder-service:1.25.0

USER root

RUN microdnf update \
    && microdnf install --nodocs \
    tar \
    unzip \
    git \
    xz
RUN mkdir -m 0755 /nix /nix/config && chown coder:coder /nix /nix/config
RUN chown -R 1000:1000 /tmp \
    && chmod 755 /tmp

COPY [ "coder/dockerfile/nix/dotfiles/configure", "/coder/configure" ]
COPY [ "coder/dockerfile/nix/dotfiles/nix.conf", "/nix/config/nix.conf" ]
COPY [ "coder/dockerfile/nix/dotfiles/settings.json", "/tmp/settings.json" ]
COPY [ "coder/dockerfile/nix/dotfiles/vs-code.extensions", "/tmp/vs-code.extensions" ]
RUN chmod 755 /coder/configure \
    && chmod 755 /tmp/settings.json

USER coder
ENV NIX_CONF_DIR=/nix/config
ENV EXTENSIONS_GALLERY='{"serviceUrl": "https://open-vsx.org/api"}'

RUN curl -L https://releases.nixos.org/nix/nix-2.3.15/install | sh \
    && mkdir /nix/home \
    && cp -a /home/coder/. /nix/home
