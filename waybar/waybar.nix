{pkgs, ...}: {
  programs.waybar = {
    enable = true;
    systemd.enable = false;
  };
  xdg.configFile."waybar" = {
    source = ./.;
    recursive = true;
  };
  systemd.user.services.waybar = {
    Unit = {
      Description = "Waybar (bound to Niri)";
      PartOf = ["niri.service"];
      After = ["niri.service"];
      ConditionEnvironment = "WAYLAND_DISPLAY";
    };
    Service = {
      ExecStart = "${pkgs.waybar}/bin/waybar";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = ["niri.service"];
    };
  };
}
