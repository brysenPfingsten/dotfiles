{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.LazyVim.homeManagerModules.default
    ../../modules/starship.nix
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
    # SAT
    z3

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

    # Web Apps
    chromium
    wasistlos

    # GUIs
    spotify
    pavucontrol
    rofi
    vlc

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
      };
    };
    gh = {
      enable = true;
      gitCredentialHelper.enable = true;
    };
    zoxide = {
      enable = true;
      enableBashIntegration = true;
    };
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
    # Neovim
    "nvim/lua/config/options.lua".source = ../../neovim/lua/config/options.lua;
    "nvim/lua/config/keymaps.lua".source = ../../neovim/lua/config/keymaps.lua;
    "nvim/lua/plugins" = {
      source = ../../neovim/lua/plugins;
      recursive = true;
    };
    "nvim/snippets" = {
      source = ../../neovim/snippets;
      recursive = true;
    };
    # Niri
    "niri/config.kdl".source = ../../modules/niri/config.kdl;
    # Waybar
    "waybar/config.jsonc".source = ../../modules/waybar/config.jsonc;
    "waybar/style.css".source = ../../modules/waybar/style.css;
    "waybar/scripts/power-menu.sh".source = ../../modules/waybar/scripts/power-menu.sh;
    # Electron
    "electron-flags.conf".source = ../../modules/electron-flags.conf;
    # Kitty
    "kitty/current-theme.conf".source = ../../modules/kitty/current-theme.conf;
    "kitty/kitty.conf".source = ../../modules/kitty/kitty.conf;
  };

  home.file = {
    ".bashrc".source = ../../modules/terminal/bashrc;
  };

  # Tie swaybg to the niri session
}
