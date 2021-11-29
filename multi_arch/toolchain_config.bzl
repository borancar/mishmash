load("@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl", "tool_path")
load("@bazel_skylib//lib:paths.bzl", "paths")
load("@bazel_tools//tools/build_defs/cc:action_names.bzl", "ACTION_NAMES")
load("@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl", "feature", "flag_group", "flag_set")

def _tool_path(common_path, prefix, tool_name):
    return tool_path(
        name = tool_name,
        path = paths.join(common_path, prefix, "bin", "%s-%s" % (prefix, tool_name)),
    )

all_link_actions = [
    ACTION_NAMES.cpp_link_executable,
    ACTION_NAMES.cpp_link_dynamic_library,
    ACTION_NAMES.cpp_link_nodeps_dynamic_library,
]

def _impl(ctx):
    common_path = "/home/boran/x-tools"
    prefix = ctx.attr.prefix
    compiler_subpath = paths.join(common_path, prefix)

    tool_paths = [
        _tool_path(common_path, prefix, "ar"),
        _tool_path(common_path, prefix, "cpp"),
        _tool_path(common_path, prefix, "gcc"),
        _tool_path(common_path, prefix, "gcov"),
        _tool_path(common_path, prefix, "ld"),
        _tool_path(common_path, prefix, "nm"),
        _tool_path(common_path, prefix, "objdump"),
        _tool_path(common_path, prefix, "strip"),
    ]

    features = [
        feature(
            name = "default_linker_flags",
            enabled = True,
            flag_sets = [
                flag_set(
                    actions = all_link_actions,
                    flag_groups = ([
                        flag_group(
                            flags = [
                                "-lstdc++",
                            ],
                        ),
                    ]),
                ),
            ],
        ),
        feature(
            name = "static_linking_mode",
            enabled = True,
            flag_sets = [
                flag_set(
                    actions = [ACTION_NAMES.cpp_link_executable],
                    flag_groups = ([
                        flag_group(
                            flags = [
                                "-static",
                            ],
                        ),
                    ]),
                ),
            ],
        ),
    ]

    # Documented at
    # https://docs.bazel.build/versions/main/skylark/lib/cc_common.html#create_cc_toolchain_config_info.
    #
    # create_cc_toolchain_config_info is the public interface for registering
    # C++ toolchain behavior.
    return cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        features = features,
        cxx_builtin_include_directories = [
            paths.join(compiler_subpath, prefix, "include", "c++", "11.2.0"),
            paths.join(compiler_subpath, prefix, "include", "c++", "11.2.0", prefix),
            paths.join(compiler_subpath, prefix, "include", "c++", "11.2.0", "backward"),
            paths.join(compiler_subpath, "lib", "gcc", prefix, "11.2.0", "include"),
            paths.join(compiler_subpath, "lib", "gcc", prefix, "11.2.0", "include-fixed"),
            paths.join(compiler_subpath, prefix, "include"),
            paths.join("%sysroot%", "usr", "include"),
        ],
        toolchain_identifier = ctx.attr.name,
        host_system_name = ctx.attr.prefix,
        target_system_name = ctx.attr.prefix,
        target_cpu = ctx.attr.prefix.split("-")[0],
        target_libc = "glibc",
        compiler = "gcc",
        abi_version = "unknown",
        abi_libc_version = "unknown",
        tool_paths = tool_paths,
        builtin_sysroot = paths.join(compiler_subpath, prefix, "sysroot"),
    )

cc_toolchain_config = rule(
    implementation = _impl,
    attrs = {
        "prefix": attr.string(),
    },
    provides = [CcToolchainConfigInfo],
)

def x_tools_toolchain(name, prefix, compatible_with):
    files = "%s_files" % prefix
    config = "%s_config" % prefix

    native.filegroup(
        name = files
    )

    cc_toolchain_config(
        name = config,
        prefix = prefix,
    )

    native.cc_toolchain(
        name = prefix,
        all_files = files,
        ar_files = files,
        compiler_files = files,
        dwp_files = files,
        linker_files = files,
        objcopy_files = files,
        strip_files = files,
        toolchain_config = config,
    )

    native.toolchain(
        name = name,
        target_compatible_with = compatible_with,
        toolchain = prefix,
        toolchain_type = "@bazel_tools//tools/cpp:toolchain_type"
    )
