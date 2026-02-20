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

    # Web Apps
    wasistlos

    # GUIs
    pavucontrol
    vlc
    fuzzel

    # PDFs
    zathura
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
}
