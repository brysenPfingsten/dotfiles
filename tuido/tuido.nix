{...}: {
  programs.tuido = {
    enable = true;
    settings = {
      time.use_12h = true;
      sync.enabled = true;
      sync.remote = "https://github.com/brysenPfingsten/todos.git";
      # colors.region_selected = "#ff6600";
      # icons.done = "✓ ";
      # icons.todo = "○ ";
      # splash.art_color = "lightmagenta";
    };
  };
}
