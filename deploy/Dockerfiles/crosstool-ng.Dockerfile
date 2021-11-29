FROM ubuntu:16.04

ENV CT_PREFIX=/x-tools

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# hadolint ignore=DL3008
RUN apt-get update -y && apt-get install -y apt-transport-https curl gnupg
RUN curl -fsSL https://bazel.build/bazel-release.pub.gpg | gpg --dearmor > bazel.gpg
RUN mv bazel.gpg /etc/apt/trusted.gpg.d/
RUN echo "deb [arch=amd64] https://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list
# hadolint ignore=DL3008
RUN apt-get update && apt-get install -y bazel build-essential \
    patch git autoconf flex texinfo gawk libtool libtool-bin \
    ncurses-dev ncurses-bin bison help2man bzip2 python python3 python-dev python3-dev \
    liblzma5 xz-utils && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN useradd -ms /bin/bash bazel
RUN mkdir /x-tools && chown bazel.bazel /x-tools
USER bazel
WORKDIR /home/bazel
RUN git clone https://github.com/crosstool-ng/crosstool-ng
WORKDIR /home/bazel/crosstool-ng
RUN ./bootstrap && ./configure --enable-local && make
RUN ./ct-ng aarch64-unknown-linux-gnu && ./ct-ng build
RUN ./ct-ng powerpc64le-unknown-linux-gnu && ./ct-ng build
RUN ./ct-ng x86_64-unknown-linux-gnu && ./ct-ng build
WORKDIR /home/bazel
RUN rm -rf /home/bazel/crosstool-ng