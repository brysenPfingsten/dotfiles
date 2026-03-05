{pkgs, ...}: {
  home.packages = with pkgs; [
    # Web Apps
    wasistlos
    # PDFs
    foliate
    # File manager stuff
    nautilus
    adwaita-icon-theme
    gnome.gvfs
  ];
}
