load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def libuv():
    http_archive(
        name = "libuv",
        url = "https://github.com/libuv/libuv/archive/refs/tags/v1.42.0.tar.gz",
        sha256 = "371e5419708f6aaeb8656671f89400b92a9bba6443369af1bb70bcd6e4b3c764",
        strip_prefix = "libuv-1.42.0",
        build_file = "//third_party/libuv:BUILD.libuv",
    )
