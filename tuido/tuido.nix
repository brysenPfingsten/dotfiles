{...}: {
  programs.tuido = {
    enable = true;
    settings = {
      time.use_12h = true;
      # colors.region_selected = "#ff6600";
      # icons.done = "✓ ";
      # icons.todo = "○ ";
      # splash.art_color = "lightmagenta";
    };
  };
}
