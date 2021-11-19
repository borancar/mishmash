load("@rules_cc//cc:defs.bzl", "cc_binary")
load("@rules_pkg//:mappings.bzl", "pkg_attributes", "pkg_filegroup", "pkg_files", "pkg_mkdirs", "strip_prefix")
load("@rules_pkg//:pkg.bzl", "pkg_tar")
load("//multi_arch:defs.bzl", "multi_arch_rule")

cc_binary(
    name = "server",
    srcs = ["server.c"],
    deps = [
        "@libuv",
    ],
)

multi_arch_rule(
    name = "server_myplatform1",
    actual_binary = ":server",
    cpu = "k8",
)

multi_arch_rule(
    name = "server_myplatform2",
    actual_binary = ":server",
    cpu = "aarch64",
)

multi_arch_rule(
    name = "server_myplatform3",
    actual_binary = ":server",
    cpu = "ppc",
)

pkg_files(
    name = "myplatform1_files",
    srcs = [
        ":server_myplatform1",
    ],
    prefix = "/myplatform1",
)

pkg_files(
    name = "myplatform2_files",
    srcs = [
        ":server_myplatform2",
    ],
    prefix = "/myplatform2",
)

pkg_files(
    name = "myplatform3_files",
    srcs = [
        ":server_myplatform3",
    ],
    prefix = "/myplatform3",
)

pkg_tar(
    name = "package",
    srcs = [
        ":myplatform1_files",
        ":myplatform2_files",
        ":myplatform3_files",
    ],
)
