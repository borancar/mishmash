# Mishmash

Mismash is a demo Bazel project demonstrating fat packages, with binaries built
for different architectures coming from a single build.

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

To build a distributable package use:

```
bazel build //server:package
```

This will result in `bazel-bin/server/package.tar` with the following contents:

```
$ tar -tf bazel-bin/server/package.tar
./
./myplatform1/
./myplatform1/server
./myplatform2/
./myplatform2/server
./myplatform3/
./myplatform3/server
```

## Running

You can use [QEMU User space
emulator](https://www.qemu.org/docs/master/user/main.html) to launch these
binaries, e.g.:
```
tar -xvf bazel-bin/server/package.tar
qemu-aarch64-static mishmash2/server
```

Interacting with the server is then a case of:
```
$ nc localhost 7000
echo
echo
```
