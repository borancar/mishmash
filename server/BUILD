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
    platform = "//multi_arch:linux_x86_64",
)

multi_arch_rule(
    name = "server_myplatform2",
    actual_binary = ":server",
    platform = "//multi_arch:linux_aarch64",
)

multi_arch_rule(
    name = "server_myplatform3",
    actual_binary = ":server",
    platform = "//multi_arch:linux_ppc64le",
)

pkg_files(
    name = "myplatform1_files",
    srcs = [
        ":server_myplatform1",
    ],
    prefix = "/myplatform1",
    attributes = pkg_attributes("0755"),
)

pkg_files(
    name = "myplatform2_files",
    srcs = [
        ":server_myplatform2",
    ],
    prefix = "/myplatform2",
    attributes = pkg_attributes("0755"),
)

pkg_files(
    name = "myplatform3_files",
    srcs = [
        ":server_myplatform3",
    ],
    prefix = "/myplatform3",
    attributes = pkg_attributes("0755"),
)

pkg_tar(
    name = "package",
    srcs = [
        ":myplatform1_files",
        ":myplatform2_files",
        ":myplatform3_files",
    ],
)
