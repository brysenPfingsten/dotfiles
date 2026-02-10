{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    brightnessctl
    # For screen mirroring
    wl-mirror
    jq
  ];
  xdg.configFile."niri" = {
    source = ./.;
    recursive = true;
  };
}
