{...}: {
  programs.waybar = {
    enable = true;
    systemd.enable = true;
  };
  xdg.configFile."waybar" = {
    source = ../../../waybar;
    recursive = true;
  };
  # Waybar as a user service bound to Niri
  # systemd.user.services.waybar = {
  #   Unit = {
  #     Description = "Waybar (bound to Niri)";
  #     PartOf = ["niri.service"];
  #     After = ["niri.service"];
  #     ConditionEnvironment = "WAYLAND_DISPLAY";
  #   };
  #   Service = {
  #     ExecStart = "${pkgs.waybar}/bin/waybar";
  #     Restart = "on-failure";
  #   };
  #   Install = {
  #     WantedBy = ["niri.service"];
  #   };
  # };
}
