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
    # Clipboard
    clipse
    (writeShellScriptBin "caffeine" ''
      notify-send "Caffeine" "Screen lock disabled for 30 minutes" -t 5000
      systemctl --user stop hypridle
      sleep 1800
      systemctl --user start hypridle
      notify-send "Caffeine" "Screen lock re-enabled" -t 5000
    '')
  ];
  programs.niri.package = pkgs.niri-unstable;
  programs.niri.enable = true;
  programs.niri.settings = lib.mkMerge [
    (import ./binds.nix)
    (import ./layouts.nix)
    (import ./overview.nix)
    (import ./animations.nix)
    (import ./window-rules.nix)
    (import ./startup.nix)
    (import ./misc.nix)
  ];
}
