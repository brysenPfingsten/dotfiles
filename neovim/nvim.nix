{pkgs, ...}: {
  home.packages = with pkgs; [
    # Nix
    nixd
    alejandra
    # Lua
    stylua
    lua-language-server
    # Typst
    typst
    tinymist
    typstyle
    # C
    clang-tools
    lldb
    # Racket
    racket
    # Python
    python3
    python313Packages.pytest_7
    pyright
    ruff
    black
    uv
    # Javascript / Typescript
    nodejs
    typescript-language-server
    # SAT
    z3
    graphviz
    # Rust
    rust-analyzer
    rustc
    cargo
    clippy
    rustfmt
    pkg-config
    # LaTeX
    texlive.combined.scheme-full
    fontconfig

    # Development
    tree-sitter
    xclip
    lazydocker
    docker
    docker-compose
  ];
  programs.neovim.enable = true;
  xdg.configFile."nvim" = {
    source = ./.;
    recursive = true;
  };
}
