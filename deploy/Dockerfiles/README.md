# Dockerfiles

## Crosstool-ng

The [crosstool-ng Dockerfile](crosstool-ng.Dockerfile) is used to provider an image for Coder with the mishmash toolchains pre-built (these can take ~30mins each to build).

The image should use a multi-stage builder, due to vast amounts of source being pulled and built. In the meatime, using `--squash` will bring your container image down to a reasonable size (~1.3G). 

