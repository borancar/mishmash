let pkgs = import <nixpkgs> {};
    crossPkgs = pkgs.pkgsCross.aarch64-multiplatform;
    crossGCC = crossPkgs.buildPackages.gcc;
    crossGCCUnwrapped = crossPkgs.buildPackages.gcc-unwrapped;
    crossBinutils = crossPkgs.buildPackages.binutils;
    crossBinutilsUnwrapped = crossPkgs.buildPackages.binutils-unwrapped;

    prefixStrippedGCC = pkgs.runCommand "gcc-aarch64-symlinks" {} ''
      mkdir -p $out/bin
      for tool in \
        ar \
        dwp \
        nm \
        objcopy \
        objdump \
        strip
      do
          ln -s ${crossBinutilsUnwrapped}/bin/aarch64-unknown-linux-gnu-$tool $out/bin/$tool
      done;
      ln -s ${crossBinutils}/bin/aarch64-unknown-linux-gnu-ld $out/bin/ld
      for tool in \
        cc \
        gcov
      do
          ln -s ${crossGCC}/bin/aarch64-unknown-linux-gnu-$tool $out/bin/$tool
      done;
      ln -s ${crossGCCUnwrapped}/bin/aarch64-unknown-linux-gnu-cpp $out/bin/cpp
      '';

in
{ cc-aarch64 = pkgs.buildEnv {
    name = "cc-aarch64-env";
    paths =
      [ prefixStrippedGCC
      ];
  };
  inherit pkgs;
}
