let crossPkgs = pkgs.pkgsCross.powernv;
    haskellNix = import (builtins.fetchTarball https://github.com/input-output-hk/haskell.nix/archive/0d781c04c4ab9045a165bacf428b043995a167f6.tar.gz) {};
    pkgs = import haskellNix.sources.nixpkgs haskellNix.nixpkgsArgs;
    crossGCC = crossPkgs.buildPackages.gcc;
    crossGCCUnwrapped = crossPkgs.buildPackages.gcc-unwrapped;
    crossBinutils = crossPkgs.buildPackages.binutils;
    crossBinutilsUnwrapped = crossPkgs.buildPackages.binutils-unwrapped;

    prefixStrippedGCC = pkgs.runCommand "gcc-ppc64le-symlinks" {} ''
      mkdir -p $out/bin
      for tool in \
        ar \
        dwp \
        nm \
        objcopy \
        objdump \
        strip
      do
          ln -s ${crossBinutilsUnwrapped}/bin/powerpc64le-unknown-linux-gnu-$tool $out/bin/$tool
      done;
      ln -s ${crossBinutils}/bin/powerpc64le-unknown-linux-gnu-ld $out/bin/ld
      for tool in \
        cc \
        gcov
      do
          ln -s ${crossGCC}/bin/powerpc64le-unknown-linux-gnu-$tool $out/bin/$tool
      done;
      ln -s ${crossGCCUnwrapped}/bin/powerpc64le-unknown-linux-gnu-cpp $out/bin/cpp
      '';

in
{ cc-ppc64le = pkgs.buildEnv {
    name = "cc-ppc64le-env";
    paths =
      [ prefixStrippedGCC
      ];
  };
  inherit pkgs;
}
