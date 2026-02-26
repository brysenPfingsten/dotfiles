{
  binds = {
    ### Window Management
    # Moving between windows
    "Mod+H".action.focus-column-left = {};
    "Mod+J".action.focus-workspace-down = {};
    "Mod+K".action.focus-workspace-up = {};
    "Mod+L".action.focus-column-right = {};
    # Moving windows
    "Mod+Ctrl+H".action.move-column-left = {};
    "Mod+Ctrl+J".action.move-workspace-down = {};
    "Mod+Ctrl+K".action.move-workspace-up = {};
    "Mod+Ctrl+L".action.move-column-right = {};
    # Moving Monitors
    "Mod+Shift+H".action.focus-monitor-left = {};
    "Mod+Shift+J".action.focus-monitor-down = {};
    "Mod+Shift+K".action.focus-monitor-up = {};
    "Mod+Shift+L".action.focus-monitor-right = {};
    # Moving columns to other monitor
    "Mod+Shift+Ctrl+H".action.move-column-to-monitor-left = {};
    "Mod+Shift+Ctrl+J".action.move-column-to-monitor-down = {};
    "Mod+Shift+Ctrl+K".action.move-column-to-monitor-up = {};
    "Mod+Shift+Ctrl+L".action.move-column-to-monitor-right = {};
    # Goto workspace
    "Mod+1".action.focus-workspace = 1;
    "Mod+2".action.focus-workspace = 2;
    "Mod+3".action.focus-workspace = 3;
    "Mod+4".action.focus-workspace = 4;
    "Mod+5".action.focus-workspace = 5;
    "Mod+6".action.focus-workspace = 6;
    "Mod+7".action.focus-workspace = 7;
    "Mod+8".action.focus-workspace = 8;
    "Mod+9".action.focus-workspace = 9;
    # Move to workspace
    "Mod+Ctrl+1".action.move-column-to-workspace = 1;
    "Mod+Ctrl+2".action.move-column-to-workspace = 2;
    "Mod+Ctrl+3".action.move-column-to-workspace = 3;
    "Mod+Ctrl+4".action.move-column-to-workspace = 4;
    "Mod+Ctrl+5".action.move-column-to-workspace = 5;
    "Mod+Ctrl+6".action.move-column-to-workspace = 6;
    "Mod+Ctrl+7".action.move-column-to-workspace = 7;
    "Mod+Ctrl+8".action.move-column-to-workspace = 8;
    "Mod+Ctrl+9".action.move-column-to-workspace = 9;

    # Applications
    "Mod+T".action.spawn = "kitty";
    "Mod+B".action.spawn = "firefox";
    "Mod+M".action.spawn = ["spotify" "--enable-features=UseOzonePlatform,WaylandWindowDecorations" "--ozone-platform=wayland" "%U"];
    "Mod+Space".action.spawn = "fuzzel";
    "Mod+N".action.spawn = ["swaync-client" "-t"];
    "Mod+P" = {
      action.spawn = ["wl-mirror" "$(niri" "msg" "--json focused-output" "|" "jq" "-r" ".name)"];
      repeat = false;
    };
    # TUIs
    "Mod+D".action.spawn = ["kitty"];
    "Mod+Shift+W".action.spawn = ["kitty" "--class=popup-term" "-e impala"];
    "Mod+Shift+B".action.spawn = ["kitty" "--class=popup-term" "-e bluetui"];
    "Mod+Shift+D".action.spawn = ["kitty" "--class=popup-term" "-e lazydocker"];
    "Mod+V".action.spawn = ["kitty" "--class=popup-term" "-e" "clipse"];
    "Mod+Shift+Return".action.spawn = ["kitty --class=popup-term"];

    # Brightness
    "XF86MonBrightnessUp" = {
      allow-when-locked = true;
      action.spawn = ["brightnessctl" "--class=backlight" "set" "+10%"];
    };
    "XF86MonBrightnessDown" = {
      allow-when-locked = true;
      action.spawn = ["brightnessctl" "--class=backlight" "set" "10%-"];
    };

    # Audio
    "XF86AudioRaiseVolume" = {
      allow-when-locked = true;
      action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+"];
    };
    "XF86AudioLowerVolume" = {
      allow-when-locked = true;
      action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-"];
    };
    "XF86AudioMute" = {
      allow-when-locked = true;
      action.spawn = ["wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"];
    };
    "XF86AudioMicMute" = {
      allow-when-locked = true;
      action.spawn = ["wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"];
    };
    "XF86AudioPlay".action.spawn = ["playerctl" "play-pause"];
    "XF86AudioNext".action.spawn = ["playerctl" "next"];
    "XF86AudioPrev".action.spawn = ["playerctl" "previous"];

    # Other Actions
    "Mod+Q" = {
      repeat = false;
      action.close-window = {};
    };
    "Mod+W".action.spawn = ["sh" "-c" "systemctl --user is-active --quiet waybar && systemctl --user stop waybar || systemctl --user start waybar"];
    "Mod+O".action.toggle-overview = {};
    "Mod+R".action.switch-preset-column-width = {};
    "Mod+Shift+R".action.switch-preset-window-height = {};
    "Mod+Ctrl+R".action.reset-window-height = {};
    "Mod+F".action.maximize-column = {};
    "Mod+Shift+F".action.fullscreen-window = {};
    "Mod+Ctrl+F".action.expand-column-to-available-width = {};
    "Mod+Minus".action.set-column-width = "-10%";
    "Mod+Equal".action.set-column-width = "+10%";
    "Mod+Shift+Minus".action.set-window-height = "-10%";
    "Mod+Shift+Equal".action.set-window-height = "+10%";
    "Ctrl+Alt+Delete".action.quit = {};
    "Mod+Shift+P".action.power-off-monitors = {};
    # "Super+Alt+L".action.spawn = "swaylock";

    # Screenshotting
    "Print".action.screenshot = {};
    "Ctrl+Print".action.screenshot-screen = {};
    "Alt+Print".action.screenshot-window = {};
    "Alt+P".action.screenshot = {};
  };
}
