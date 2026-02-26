{...}: {
  programs.zathura.enable = true;
  programs.fuzzel.enable = true;
  programs.yazi.enable = true;

  catppuccin = {
    flavor = "mocha";
    accent = "blue";
    firefox = {
      enable = true;
      force = true;
    };
    btop.enable = true;
    kitty.enable = true;
    zathura.enable = true;
    fuzzel.enable = true;
    lazygit.enable = true;
    starship.enable = true;
    yazi.enable = true;
    swaync.enable = true;
  };
}
