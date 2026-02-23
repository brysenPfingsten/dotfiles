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
    starship
    impala
    bluetui
    btop
    wiremix
    clipse
    yazi

    # File manager stuff
    nautilus
    adwaita-icon-theme
    gnome.gvfs
  ];
  programs.fuzzel.enable = true;
}
