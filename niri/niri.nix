{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    brightnessctl
    sunsetr
  ];
  xdg.configFile."niri" = {
    source = ./.;
    recursive = true;
  };
}
