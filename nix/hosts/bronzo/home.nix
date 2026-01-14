{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.LazyVim.homeManagerModules.default
    ../../../pywal/pywal.nix
    ../../../niri/niri.nix
    ../../../git/git.nix
    ../../../neovim/nvim.nix
    ../../../kitty/kitty.nix
    ../../../bash/bash.nix
    ../../../starship/starship.nix
    ../../../dooit/dooit.nix
    ../../../waybar/waybar.nix
    ../../../starship/starship.nix
    ../../../firefox/firefox.nix
    ../../../spotify/spotify.nix
    ../../../packages/packages.nix
    ../../../sunsetr/sunsetr.nix
    ../../../mako/mako.nix
  ];
  home = {
    username = "pfingsbr";
    homeDirectory = "/home/pfingsbr";
    stateVersion = "25.11";
  };

  programs.home-manager.enable = true;

  xdg.enable = true;
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = ["papers.desktop"];
      "text/html" = ["firefox.desktop"];
      "x-scheme-handler/http" = ["firefox.desktop"];
      "x-scheme-handler/https" = ["firefox.desktop"];
      "x-scheme-handler/about" = ["firefox.desktop"];
      "x-scheme-handler/unknown" = ["firefox.desktop"];
    };
  };
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-gtk
    pkgs.xdg-desktop-portal-wlr
  ];
}
