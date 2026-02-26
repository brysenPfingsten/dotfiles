{
  pkgs,
  inputs,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in {
  programs.spicetify = {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      adblockify
      hidePodcasts
      shuffle
      keyboardShortcut
    ];
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "mocha";
  };

  xdg.desktopEntries.spotify = {
    name = "Spotify";
    genericName = "Music Player";
    exec = "spotify --enable-features=UseOzonePlatform,WaylandWindowDecorations --ozone-platform=wayland %U";
    icon = "spotify-client";
    type = "Application";
    terminal = false;
    categories = ["Audio" "Music" "Player"];
    mimeType = ["x-scheme-handler/spotify"];
  };
}
