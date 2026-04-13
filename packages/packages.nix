{pkgs, ...}: {
  home.packages = with pkgs; [
    # Web Apps
    wasistlos
    # PDFs
    foliate
    zotero
    # File manager stuff
    nautilus
    adwaita-icon-theme
    gnome.gvfs
  ];
}
