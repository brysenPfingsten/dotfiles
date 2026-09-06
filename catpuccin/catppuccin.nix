{...}: {
  programs.zathura.enable = true;
  programs.fuzzel.enable = true;
  programs.yazi = {
    enable = true;
    shellWrapperName = "y";
  };

  catppuccin = {
    enable = true;
    autoEnable = true;
    flavor = "mocha";
    accent = "blue";
    firefox = {
      enable = true;
      force = true;
    };
    btop.enable = true;
    kitty.enable = true;
    # zathura.enable = true;
    fuzzel.enable = true;
    lazygit.enable = true;
    yazi.enable = true;
    swaync.enable = true;
    hyprlock.enable = false;
  };
}
