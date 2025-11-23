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
  codex-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "codex.nvim";
    version = "git-2025-08-20";

    src = pkgs.fetchFromGitHub {
      owner = "johnseth97";
      repo = "codex.nvim";
      rev = "main";
      sha256 = "0nmmbchyjcrllk9ligg9714mjf5c0gv9f2xfb2aq1pnmpjl6rw46";
    };
  };
in {
  imports = [
    inputs.LazyVim.homeManagerModules.default
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

    # Development
    tree-sitter
    xclip
    lazygit
    lazydocker
    git
    gh
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
    kitty
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

    # Wallpaper
    swaybg
    brightnessctl
  ];

  programs = {
    home-manager.enable = true;
    lazyvim.enable = true;
    neovim.plugins = with pkgs.vimPlugins; [
      telescope-nvim
      telescope-fzf-native-nvim
      (nvim-treesitter.withAllGrammars)
      compiler-nvim
      nvim-autopairs
      nvim-colorizer-lua
      overseer-nvim
      vimtex
      nvim-ufo
      onedark-nvim
      luasnip
      friendly-snippets
      nvim-jdtls
      neotest
      neotest-python
      rustaceanvim
      crates-nvim
      codex-nvim
    ];
    waybar = {
      enable = true;
      systemd.enable = false;
    };
    git = {
      enable = true;
      userName = "Brysen Pfingsten";
      userEmail = "brysen.pfingsten@gmail.com";
      extraConfig = {
        init.defaultBranch = "main";
        pull.rebase = true;
        credential.helper = "!/etc/profiles/per-user/${config.home.username}/bin/gh auth git-credential";
        diff.tool = "difft";
      };
    };
    gh = {
      enable = true;
      gitCredentialHelper.enable = true;
    };
    zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
    };
    starship.enable = true;
  };
  # Waybar as a user service bound to Niri
  systemd.user.services.waybar = {
    Unit = {
      Description = "Waybar (bound to Niri)";
      PartOf = ["niri.service"];
      After = ["niri.service"];
      ConditionEnvironment = "WAYLAND_DISPLAY";
    };
    Service = {
      ExecStart = "${pkgs.waybar}/bin/waybar";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = ["niri.service"];
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
    "nvim" = {
      source = ../../../neovim;
      recursive = true;
    };

    "niri/config.kdl".source = ../../../niri/config.kdl;

    "waybar" = {
      source = ../../../waybar;
      recursive = true;
    };

    "electron-flags.conf".source = ../../../electron/electron-flags.conf;

    "kitty" = {
      source = ../../../kitty;
      recursive = true;
    };

    "dooit" = {
      source = ../../../dooit;
      recursive = true;
    };
    "starship".source = ../../../starship/starship.toml;

    # "rofi" = {
    #   source = ../../../rofi;
    #   recursive = true;
    # };
  };

  home.file = {
    ".bashrc".source = ../../../bash/bashrc;
  };

  # Tie swaybg to the niri session
}
