{
  "window-rules" = [
    # Firefox Picture-in-Picture
    {
      matches = [
        {
          "app-id" = "firefox$";
          title = "^Picture-in-Picture$";
        }
      ];
      "open-floating" = true;
    }

    # Transparent Terminals
    {
      matches = [
        {"app-id" = "^(kitty|nvim)";}
      ];
      "draw-border-with-background" = false;
    }

    # Floating Terminals
    {
      matches = [
        {"app-id" = "^popup-term$";}
      ];
      "open-floating" = true;
      "default-column-width" = {proportion = 0.8;};
      "default-window-height" = {proportion = 0.8;};
      "draw-border-with-background" = false;
    }
  ];
}
