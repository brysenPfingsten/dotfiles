{
  config,
  pkgs,
  ...
}: let
  wallDir = "${config.home.homeDirectory}/Pictures";

  wallpick = pkgs.writeShellScriptBin "wallpick" ''
    set -euo pipefail

    mapfile -t files < <(${pkgs.findutils}/bin/find "${wallDir}" -type f \
      \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.webp" \) | ${pkgs.coreutils}/bin/sort)

    [ "''${#files[@]}" -gt 0 ] || exit 1

    choice="$(printf '%s\n' "''${files[@]}" | ${pkgs.rofi}/bin/rofi -dmenu -i -p "Wallpaper")"
    [ -n "$choice" ] || exit 0

    ${pkgs.swww}/bin/swww img "$choice" --transition-type any --transition-duration 0.6
    ${pkgs.pywal16}/bin/wal -i "$choice" -n
    kitty @ set-colors --all --configured ~/.cache/wal/colors-kitty.conf || true
  '';
in {
  home.packages = with pkgs; [
    pywal16
    imagemagick
    swww
    wallpick
    rofi
    nsxiv
  ];

  systemd.user.services.swww = {
    Unit = {
      Description = "swww wallpaper daemon";
      After = ["graphical-session.target"];
      PartOf = ["graphical-session.target"];
    };
    Service = {
      ExecStart = "${pkgs.swww}/bin/swww-daemon";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };
}
