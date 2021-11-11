load("@//third_party/libuv:libuv.bzl", "libuv")

def third_party_deps():
    """Load 3rd party dependencies"""

    #DEPENDENCIES_LINTER_START#
    libuv()
    #DEPENDENCIES_LINTER_END#
