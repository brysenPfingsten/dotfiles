{pkgs, ...}: {
  home.packages = with pkgs; [
    kitty
  ];
  xdg.configFile."kitty" = {
    source = ./.;
    recursive = true;
  };
}
