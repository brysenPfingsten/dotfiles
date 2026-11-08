{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../../common/home.nix
  ];

  home.packages = [
    (pkgs.callPackage ../../../packages/horizon-launcher.nix {})
  ];

  programs.niri.settings = lib.mkMerge [
    (import ./niri-outputs.nix)
    (import ./niri-input.nix)
  ];
}
