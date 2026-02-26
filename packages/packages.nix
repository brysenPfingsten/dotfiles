{pkgs, ...}: {
  home.packages = with pkgs; [
    # CLIs
    unzip
    zoxide
    eza
    ripgrep
    fd
    bat
    playerctl
    fastfetch
    difftastic
    wl-clipboard
    codex
    swww

    # Web Apps
    wasistlos

    # GUIs
    pavucontrol
    vlc

    # PDFs
    foliate

    # Terminal and TUIs
    impala
    bluetui
    btop
    wiremix
    clipse

    # File manager stuff
    nautilus
    adwaita-icon-theme
    gnome.gvfs
  ];
  programs.fuzzel.enable = true;
}
