{pkgs, ...}: let
  codelldb = pkgs.writeShellScriptBin "codelldb" ''
    exec ${pkgs.vscode-extensions.vadimcn.vscode-lldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb "$@"
  '';
in {
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
    uv
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
    typst

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
    pavucontrol
    vlc
    fuzzel

    # PDFs
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
}
