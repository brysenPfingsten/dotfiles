{pkgs, ...}: {
  home.packages = with pkgs; [
    # Web Apps
    karere
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
