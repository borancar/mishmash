load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "bazel_skylib",
    urls = [
        "https://github.com/bazelbuild/bazel-skylib/releases/download/1.1.1/bazel-skylib-1.1.1.tar.gz",
        "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.1.1/bazel-skylib-1.1.1.tar.gz",
    ],
    sha256 = "c6966ec828da198c5d9adbaa94c05e3a1c7f21bd012a0b29ba8ddbccb2c93b0d",
)
load("@bazel_skylib//:workspace.bzl", "bazel_skylib_workspace")
bazel_skylib_workspace()

http_archive(
    name = "rules_cc",
    urls = ["https://github.com/bazelbuild/rules_cc/releases/download/0.0.1/rules_cc-0.0.1.tar.gz"],
    sha256 = "4dccbfd22c0def164c8f47458bd50e0c7148f3d92002cdb459c2a96a68498241",
)
load("@rules_cc//cc:repositories.bzl", "rules_cc_dependencies", "rules_cc_toolchains")
rules_cc_dependencies()

http_archive(
    name = "io_tweag_rules_nixpkgs",
    strip_prefix = "rules_nixpkgs-075794009270b12986d3d840e4fc065a3aceba00",
    urls = ["https://github.com/tweag/rules_nixpkgs/archive/075794009270b12986d3d840e4fc065a3aceba00.tar.gz"],
    sha256 = "9b97f6cce67bd2a005089ca108358e9bbc24531794a9d1f8ca537470ee8ca2d1",
)
load("@io_tweag_rules_nixpkgs//nixpkgs:nixpkgs.bzl", "nixpkgs_cc_configure", "nixpkgs_git_repository")
nixpkgs_git_repository(
    name = "nixpkgs",
    revision = "ad4db3f4d8ae54482c63c31c14921cb73953548d",
)
nixpkgs_cc_configure(
    name = "nixpkgs_config_cc_linux_x86_64",
    exec_constraints = [
	"@platforms//os:linux",
	"@platforms//cpu:x86_64",
    ],
    repository = "@nixpkgs",
    target_constraints = [
	"@platforms//os:linux",
	"@platforms//cpu:x86_64",
    ],
)
nixpkgs_cc_configure(
    name = "nixpkgs_config_cc_linux_aarch64",
    attribute_path = "cc-aarch64",
    exec_constraints = [
	"@platforms//os:linux",
	"@platforms//cpu:x86_64",
    ],
    nix_file = "//:arm-cross.nix",
    repository = "@nixpkgs",
    target_constraints = [
	"@platforms//os:linux",
	"@platforms//cpu:aarch64",
    ],
)
nixpkgs_cc_configure(
    name = "nixpkgs_config_cc_linux_ppc64le",
    attribute_path = "cc-ppc64le",
    exec_constraints = [
	"@platforms//os:linux",
	"@platforms//cpu:x86_64",
    ],
    nix_file = "//:ppc-cross.nix",
    repository = "@nixpkgs",
    target_constraints = [
	"@platforms//os:linux",
	"@platforms//cpu:ppc",
    ],
)

#rules_cc_toolchains()
#register_toolchains(
#    "//multi_arch:linux_x86_64_toolchain",
#    "//multi_arch:linux_aarch64_toolchain",
#    "//multi_arch:linux_ppc64le_toolchain",
#)

register_execution_platforms("//multi_arch:linux_x86_64")

http_archive(
    name = "rules_foreign_cc",
    sha256 = "69023642d5781c68911beda769f91fcbc8ca48711db935a75da7f6536b65047f",
    strip_prefix = "rules_foreign_cc-0.6.0",
    url = "https://github.com/bazelbuild/rules_foreign_cc/archive/0.6.0.tar.gz",
)
load("@rules_foreign_cc//foreign_cc:repositories.bzl", "rules_foreign_cc_dependencies")
# This sets up some common toolchains for building targets. For more details, please see
# https://bazelbuild.github.io/rules_foreign_cc/0.6.0/flatten.html#rules_foreign_cc_dependencies
rules_foreign_cc_dependencies()

# load 3rd party deps
load("//third_party:dependencies.bzl", "third_party_deps")
third_party_deps()

http_archive(
    name = "rules_pkg",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/rules_pkg/releases/download/0.5.1/rules_pkg-0.5.1.tar.gz",
        "https://github.com/bazelbuild/rules_pkg/releases/download/0.5.1/rules_pkg-0.5.1.tar.gz",
    ],
    sha256 = "a89e203d3cf264e564fcb96b6e06dd70bc0557356eb48400ce4b5d97c2c3720d",
)
load("@rules_pkg//:deps.bzl", "rules_pkg_dependencies")
rules_pkg_dependencies()
