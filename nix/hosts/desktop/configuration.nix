{...}: {
  imports = [
    ./hardware-configuration.nix
    ../../common/configuration.nix
  ];

  networking.hostName = "desktop";

  services.jellyfin = {
    enable = true;
    openFirewall = false;
  };

  users.users.pfingsbr.extraGroups = ["jellyfin"];

  # Run AppImages directly
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  systemd.tmpfiles.rules = [
    "d /media         0775 pfingsbr jellyfin -"
    "d /media/movies  0775 pfingsbr jellyfin -"
    "d /media/shows   0775 pfingsbr jellyfin -"
    "d /media/books   0775 pfingsbr jellyfin -"
  ];
}
