{lib, ...}: {
  imports = [
    ../../common/home.nix
  ];

  programs.niri.settings = lib.mkMerge [
    (import ./niri-outputs.nix)
    (import ./niri-input.nix)
  ];
}
