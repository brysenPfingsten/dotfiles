{
  pkgs,
  inputs,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in {
  programs.spicetify = {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      adblockify
      hidePodcasts
      shuffle
    ];
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";
  };

  # Override the desktop entry to force Wayland flags (no package wrapping)
  xdg.desktopEntries.spotify = {
    name = "Spotify";
    genericName = "Music Player";
    exec = "spotify --enable-features=UseOzonePlatform,WaylandWindowDecorations --ozone-platform=wayland %U";
    icon = "spotify";
    type = "Application";
    terminal = false;
    categories = ["Audio" "Music" "Player"];
    mimeType = ["x-scheme-handler/spotify"];
  };
}
