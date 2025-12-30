{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: let
  spotify-wayland = pkgs.spotify.overrideAttrs (old: {
    nativeBuildInputs = (old.nativeBuildInputs or []) ++ [pkgs.makeWrapper];
    postFixup =
      (old.postFixup or "")
      + ''
        wrapProgram $out/bin/spotify \
          --add-flags "--enable-features=UseOzonePlatform" \
          --add-flags "--ozone-platform=wayland"
      '';
  });
  codelldb = pkgs.writeShellScriptBin "codelldb" ''
    exec ${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb "$@"
  '';
in {
  imports = [
    inputs.LazyVim.homeManagerModules.default
    ../../../pywal/pywal.nix
    ../../../niri/niri.nix
    ../../../git/git.nix
    ../../../neovim/nvim.nix
    ../../../kitty/kitty.nix
    ../../../starship/starship.nix
  ];
  home = {
    username = "pfingsbr";
    homeDirectory = "/home/pfingsbr";
    stateVersion = "25.05";
  };

  home.packages = with pkgs; [
    # Languages, Language Servers and Formatters
    # C
    clang-tools
    lldb
    codelldb
    # Nix
    nixd
    alejandra
    # Racket
    racket
    # racket-langserver # Racket
    # raco-fmt
    lua-language-server
    # Lua
    stylua
    # Python
    python3
    python313Packages.pytest_7
    pyright
    ruff
    black
    # Javascript
    nodejs
    # Rust
    rust-analyzer
    rustc
    cargo
    clippy
    rustfmt
    pkg-config
    # Javascript / Typescript
    typescript-language-server
    # SAT
    z3
    graphviz
    # LaTeX
    texlive.combined.scheme-full
    fontconfig

    # Development
    tree-sitter
    xclip
    lazydocker
    docker
    docker-compose

    # CLIs
    unzip
    zoxide
    eza
    ripgrep
    fd
    bat
    playerctl
    fastfetch
    difftastic
    wl-clipboard
    codex

    # Web Apps
    chromium
    wasistlos

    # GUIs
    spotify-wayland
    pavucontrol
    vlc
    fuzzel

    # PDFs
    papers
    zathura
    pympress
    foliate

    # Terminal and TUIs
    starship
    impala
    bluetui
    btop
    wiremix
    clipse
    superfile

    # File manager stuff
    nautilus
    adwaita-icon-theme
    gnome.gvfs
  ];

  programs = {
    home-manager.enable = true;
    zoxide = {
      enable = true;
      enableBashIntegration = true;
    };
  };

  xdg.enable = true;
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = ["papers.desktop"];
      "text/html" = ["firefox.desktop"];
      "x-scheme-handler/http" = ["firefox.desktop"];
      "x-scheme-handler/https" = ["firefox.desktop"];
      "x-scheme-handler/about" = ["firefox.desktop"];
      "x-scheme-handler/unknown" = ["firefox.desktop"];
    };
  };
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-gtk
    pkgs.xdg-desktop-portal-wlr
  ];
  xdg.configFile = {
    "dooit" = {
      source = ../../../dooit;
      recursive = true;
    };

    "sunsetr" = {
      source = ../../../sunsetr;
      recursive = true;
    };
  };

  home.file = {
    ".bashrc".source = ../../../bash/bashrc;
  };
}
