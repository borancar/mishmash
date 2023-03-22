# Mishmash

Mismash is a demo Bazel project demonstrating fat packages, with binaries built
for different architectures coming from a single build.

Uses https://nixos.org/ to prepare toolchains:

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
