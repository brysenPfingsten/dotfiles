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
    clang-tools # C
    nixd
    alejandra # Nix
    racket
    racket-langserver # Racket
    raco-fmt
    lua-language-server
    stylua # Lua
    python3 # Python
    nodejs # Javascript
    rust-analyzer # Rust
    z3 # SAT

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

    # Web Apps
    chromium
    wasistlos

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

  systemd.user.services.swaybg = {
    Unit = {
      Description = "swaybg wallpaper";
      PartOf = ["graphical-session.target"];
      After = ["graphical-session.target"];
      # Optional: only start if the socket exists (we're in a Wayland session)
    };
    Service = {
      # Absolute path + correct args (-m fill)
      ExecStart = "${pkgs.swaybg}/bin/swaybg -m fill -i %h/Pictures/planet.jpg";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };

  xdg.enable = true;
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = ["papers.desktop"];
    };
  };

  xdg.configFile = {
    # Neovim
    "nvim/lua/config/options.lua".source = ../../neovim/lua/config/options.lua;
    "nvim/lua/config/keymaps.lua".source = ../../neovim/lua/config/keymaps.lua;
    "nvim/lua/plugins" = {
      source = ../../neovim/lua/plugins;
      recursive = true;
    };
    # Niri
    "niri/config.kdl".source = ../../modules/niri/config.kdl;
    # Waybar
    "waybar/config.jsonc".source = ../../modules/waybar/config.jsonc;
    "waybar/style.css".source = ../../modules/waybar/style.css;
  };

  home.file = {
    ".bashrc".source = ../../modules/terminal/bashrc;
  };

  # Tie swaybg to the niri session
}
