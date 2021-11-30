let crossPkgs = pkgs.pkgsCross.aarch64-multiplatform;
    haskellNix = import (builtins.fetchTarball https://github.com/input-output-hk/haskell.nix/archive/0d781c04c4ab9045a165bacf428b043995a167f6.tar.gz) {};
    pkgs = import haskellNix.sources.nixpkgs haskellNix.nixpkgsArgs;
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
