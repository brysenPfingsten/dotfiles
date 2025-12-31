{pkgs, ...}: {
  home.packages = with pkgs; [
    sunsetr
  ];
  xdg.configFile."sunsetr" = {
    source = ./.;
    recursive = true;
  };
}
