{pkgs, ...}: let
  waybarConfig = pkgs.runCommandLocal "waybar-config" {src = ./.;} ''
    mkdir -p "$out"
    cp -r --no-preserve=mode,ownership "$src"/. "$out"
    if [ -d "$out/scripts" ]; then
      chmod +x "$out"/scripts/*.sh
    fi
  '';
in {
  programs.waybar.enable = true;
  home.packages = with pkgs; [
    playerctl
    swww
    # Terminal and TUIs
    impala
    bluetui
    btop
    wiremix
  ];

  xdg.configFile."waybar" = {
    source = waybarConfig;
    recursive = true;
  };
}
