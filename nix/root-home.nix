{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.LazyVim.homeManagerModules.default];
  programs.lazyvim.enable = true;
  home = {
    username = "root";
    homeDirectory = "/root";
    stateVersion = "25.05";
  };
}
