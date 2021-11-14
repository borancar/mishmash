# Mishmash

Mismash is a demo project demonstrating fat packages, with binaries built for
different architectures coming from a single build.

Uses https://github.com/crosstool-ng/crosstool-ng (latest master) to prepare
toolchains:

```
git clone https://github.com/crosstool-ng/crosstool-ng
cd crosstool-ng
./configure --enable-local
make
./ct-ng aarch64-unknown-linux-gnu
./ct-ng build
./ct-ng powerpc64le-unknown-linux-gnu
./ct-ng build
./ct-ng x86_64-unknown-linux-gnu
./ct-ng build
```

This should put the tools under `~/x-tools`. Make sure to change
`multi_arch/toolchain_config.bzl:19`.

```
bazel build --crosstool_top=//multi_arch:legacy_selector //server/...
```
