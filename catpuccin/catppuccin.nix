{...}: {
  programs.zathura.enable = true;
  programs.fuzzel.enable = true;

  catppuccin = {
    flavor = "mocha";
    accent = "blue";
    firefox = {
      enable = true;
      force = true;
    };
    kitty.enable = true;
    zathura.enable = true;
    fuzzel.enable = true;
    lazygit.enable = true;
    swaync.enable = false;
  };
}
