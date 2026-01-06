{pkgs, ...}: let
  wallpick =
    pkgs.writers.writePython3Bin "wallpick" {libraries = [];} (builtins.readFile ./wallpick.py);
in {
  home.packages = with pkgs; [
    pywal16
    imagemagick
    swww
    wallpick
    rofi
    nsxiv
    spicetify-cli
  ];

  systemd.user.services.swww = {
    Unit = {
      Description = "swww wallpaper daemon";
      After = ["graphical-session.target"];
      PartOf = ["graphical-session.target"];
    };
    Service = {
      ExecStart = "${pkgs.swww}/bin/swww-daemon";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };
}
