{
  pkgs,
  lib,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    brightnessctl
    # For screen mirroring
    wl-mirror
    jq
  ];
  programs.niri.package = pkgs.niri-unstable;
  programs.niri.enable = true;
  programs.niri.settings = lib.mkMerge [
    (import ./outputs.nix)
    (import ./binds.nix)
    (import ./input.nix)
    (import ./layouts.nix)
    (import ./overview.nix)
    (import ./animations.nix)
    (import ./window-rules.nix)
    (import ./startup.nix)
    (import ./misc.nix)
  ];
}
