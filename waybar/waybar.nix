{
  pkgs,
  ...
}: let
  # Build the config directory in the store so scripts keep execute bits.
  waybarConfig = pkgs.runCommandLocal "waybar-config" {src = ./.;} ''
    mkdir -p "$out"
    cp -r --no-preserve=mode,ownership "$src"/. "$out"
    if [ -d "$out/scripts" ]; then
      chmod +x "$out"/scripts/*.sh
    fi
  '';
in {
  programs.waybar.enable = true;

  xdg.configFile."waybar" = {
    source = waybarConfig;
    recursive = true;
  };
}
