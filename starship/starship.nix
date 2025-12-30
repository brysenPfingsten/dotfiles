{...}: {
  programs.starship.enable = true;
  xdg.configFile."starship".source = ../../../starship/starship.toml;
}
