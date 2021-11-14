load("//multi_arch:toolchain_config.bzl", "x_tools_toolchain")

exports_files(["defs.bzl"])

x_tools_toolchain(
    prefix = "x86_64-unknown-linux-gnu",
)

x_tools_toolchain(
    prefix = "aarch64-unknown-linux-gnu",
)

x_tools_toolchain(
    prefix = "powerpc64le-unknown-linux-gnu",
)

cc_toolchain_suite(
    name = "legacy_selector",
    toolchains = {
        "k8": "x86_64-unknown-linux-gnu",
        "aarch64": "aarch64-unknown-linux-gnu",
        "ppc": "powerpc64le-unknown-linux-gnu",
    },
)
