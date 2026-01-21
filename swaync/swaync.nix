{pkgs, ...}: {
  home.packages = with pkgs; [
    swaynotificationcenter
    libnotify
  ];

  services.swaync = {
    enable = true;

    settings = {
      positionX = "right";
      positionY = "top";
      layer = "overlay";

      # sizes
      control-center-width = 420;
      control-center-height = 720;
      notification-window-width = 380;

      # margins
      control-center-margin-top = 8;
      control-center-margin-right = 8;
      control-center-margin-bottom = 8;
      control-center-margin-left = 8;

      # behavior
      timeout = 8;
      timeout-low = 4;
      timeout-critical = 0;
      fit-to-screen = true;
      relative-timestamps = true;

      # visuals
      notification-icon-size = 48;
      image-visibility = "when-available";
      transition-time = 200;

      # QoL
      keyboard-shortcuts = true;
      hide-on-clear = true;

      widgets = [
        "title"
        "mpris"
        "dnd"
        "notifications"
        "buttons-grid"
      ];

      widget-config = {
        title = {
          text = "󰂚  :: Notifications";
          clear-all-button = true;
          button-text = "Clear All";
        };
        dnd = {
          text = "Do Not Disturb";
        };
        mpris = {
          image-size = 96;
          image-radius = 12;
        };
        buttons-grid = {
          actions = [
            {
              label = "";
              command = "systemctl poweroff";
            }
            {
              label = "";
              command = "systemctl reboot";
            }
            # {
            #   label = "󰤄";
            #   command = "systemctl suspend";
            # }
            # {
            #   label = "󰗽";
            #   command = "hyprctl dispatch exit";
            # }
          ];
        };
      };
    };

    style = ''
      * {
        font-family: sans-serif;
        border-radius: 12px;
      }

      .control-center {
        padding: 10px;
      }

      .notification {
        margin: 6px 10px;
        padding: 10px;
      }

      .notification-row:focus,
      .notification-row:hover {
        opacity: 0.92;
      }
    '';
  };
}
