{pkgs, ...}: let
  resyntax-bin = pkgs.writeShellScriptBin "resyntax" ''
    exec ${pkgs.racket}/bin/racket -l- resyntax/cli.rkt "$@"
  '';
in {
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
    resyntax-bin
    # Python
    python3
    python313Packages.pytest_7
    pyright
    ruff
    black
    uv
    # Javascript / Typescript
    nodejs
    nodePackages.typescript
    nodePackages.prettier
    typescript-language-server
    # Java
    jdt-language-server
    google-java-format
    jdk17
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
    # Lean
    lean4
    # Rocq
    coq
    coqPackages.coq-lsp
    coqPackages.stdpp
    coqPackages.stdlib
    # LaTeX
    texlive.combined.scheme-full
    fontconfig
    texlab

    # Development
    tree-sitter
    xclip
    lazydocker
    docker
    docker-compose
    codex
    claude-code
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    SUDO_EDITOR = "nvim";
    VISUAL = "nvim";
    RUST_SRC_PATH = "${pkgs.rustPlatform.rustLibSrc}";
  };

  programs.neovim.enable = true;
  xdg.configFile."nvim" = {
    source = ./.;
    recursive = true;
  };
}
