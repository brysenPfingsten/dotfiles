{lib, ...}: {
  imports = [
    ../../common/home.nix
    ../../../batsignal/batsignal.nix
    ../../../hypridle/hypridle.nix
  ];

  programs.niri.settings = lib.mkMerge [
    (import ./niri-outputs.nix)
    (import ./niri-input.nix)
  ];
}
