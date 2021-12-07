load("@rules_python//python:defs.bzl", "py_binary")
load("@python_deps//:requirements.bzl", "requirement")

py_binary(
    name = "app",
    srcs = [
        "app.py",
    ],
    deps = [
        requirement("flask"),
    ],
)

filegroup(
    name = "app_zip",
    srcs = [":app"],
    output_group = "python_zip_file",
)
