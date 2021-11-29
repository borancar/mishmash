load("//multi_arch:toolchain_config.bzl", "x_tools_toolchain")

exports_files(["defs.bzl"])

platform(
    name = "linux_x86_64",
    constraint_values = [
        "@platforms//os:linux",
        "@platforms//cpu:x86_64",
    ],
)

platform(
    name = "linux_aarch64",
    constraint_values = [
        "@platforms//os:linux",
        "@platforms//cpu:aarch64",
    ],
)

platform(
    name = "linux_ppc64le",
    constraint_values = [
        "@platforms//os:linux",
        "@platforms//cpu:ppc",
    ],
)

x_tools_toolchain(
    name = "linux_x86_64_toolchain",
    prefix = "x86_64-unknown-linux-gnu",
    compatible_with = [
        "@platforms//cpu:x86_64",
        "@platforms//os:linux",
    ],
)

x_tools_toolchain(
    name = "linux_aarch64_toolchain",
    prefix = "aarch64-unknown-linux-gnu",
    compatible_with = [
        "@platforms//cpu:aarch64",
        "@platforms//os:linux",
    ],
)

x_tools_toolchain(
    name = "linux_ppc64le_toolchain",
    prefix = "powerpc64le-unknown-linux-gnu",
    compatible_with = [
        "@platforms//cpu:ppc",
        "@platforms//os:linux",
    ],
)

cc_toolchain_suite(
    name = "legacy_selector",
    toolchains = {
        "k8": "x86_64-unknown-linux-gnu",
        "aarch64": "aarch64-unknown-linux-gnu",
        "ppc": "powerpc64le-unknown-linux-gnu",
    },
)
