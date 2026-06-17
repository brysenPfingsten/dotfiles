{pkgs, ...}: {
  home.packages = with pkgs; [
    # Web Apps
    wasistlos
    # PDFs
    foliate
    zotero
    poppler-utils
    pympress
    # File manager stuff
    nautilus
    adwaita-icon-theme
    gnome.gvfs
  ];
}
