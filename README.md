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

This should result in multiple targets built under bazel-out:
```
$ find bazel-out/ -type f -name server                                                                                                                                                                                                                   22:22
bazel-out/k8-fastbuild/bin/server/server
bazel-out/aarch64-fastbuild-ST-7ccd83c6a482/bin/server/server
bazel-out/ppc-fastbuild-ST-a9533f43d935/bin/server/server
```

You can use [QEMU User space
emulator](https://www.qemu.org/docs/master/user/main.html) to launch these
binaries, e.g.:
```
qemu-aarch64-static bazel-out/aarch64-fastbuild-ST-7ccd83c6a482/bin/server/server
```

Interacting with the server is then a case of:
```
$ nc localhost 7000
echo
echo
```
