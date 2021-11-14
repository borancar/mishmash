load("@rules_cc//cc:defs.bzl", "cc_binary")
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
