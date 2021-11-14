def _impl(ctx):
    return [
        DefaultInfo(
            data_runfiles = ctx.attr.actual_binary[0][DefaultInfo].data_runfiles,
            default_runfiles = ctx.attr.actual_binary[0][DefaultInfo].default_runfiles,
            files = ctx.attr.actual_binary[0][DefaultInfo].files,
        ),
    ]
 
def _transition_impl(settings, attr):
    return {"//command_line_option:cpu": attr.cpu}
 
_comp_mode_transition = transition(
    implementation = _transition_impl,
    inputs = [],
    outputs = ["//command_line_option:cpu"],
)
 
multi_arch_rule = rule(
    implementation = _impl,
    attrs = {
        "cpu": attr.string(),
        "actual_binary": attr.label(cfg = _comp_mode_transition),
        "_allowlist_function_transition": attr.label(
             default = "@bazel_tools//tools/allowlists/function_transition_allowlist"
        ),
    },
)
