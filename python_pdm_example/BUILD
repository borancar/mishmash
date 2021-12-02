load("@io_bazel_rules_pex//pex:pex_rules.bzl", "pex_binary", "pex_library", "pex_test", "pex_pytest")

pex_binary(
    name = "app",
    srcs = [
        "app.py",
	"__init__.py",
    ],
    reqs = [
	"flask",
    ],
)
