{...}: {
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        hide_cursor = true;
      };
      auth = {
        "fingerprint:enabled" = true;
        "pam:enabled" = true;
        "pam:module" = "hyprlock";
      };
      background = [
        {
          path = "screenshot";
          blur_passes = 2;
          blur_size = 4;
        }
      ];
      label = [
        {
          text = "$TIME";
          font_size = 72;
          position = "0, 120";
          halign = "center";
          valign = "center";
        }
      ];
      input-field = [
        {
          size = "220, 48";
          position = "0, -40";
          halign = "center";
          valign = "center";
          outline_thickness = 2;
          dots_size = 0.25;
          dots_spacing = 0.2;
          dots_center = true;
        }
      ];
    };
  };
}
