{pkgs, ...}: {
  imports = [
    ./starship.nix
    ./zoxide.nix
  ];

  home.packages = with pkgs; [
    trash-cli
    bat
    fzf
    unzip
    zoxide
    eza
    ripgrep
    fd
    fastfetch
    wl-clipboard
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    SUDO_EDITOR = "nvim";
    VISUAL = "nvim";
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      # Listing
      ls = "exa -lh --group-directories-first --icons=auto";
      lsa = "ls -a";
      lt = "eza --tree --level=2 --long --icons --git";
      lta = "lt -a";
      # Fuzzy Finding
      ff = "fzf --preview bat --style=numbers --color=always {}";
      # Better cat
      cat = "bat --color=always";
      # Moving backwards
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      # Git
      g = "git";
      lg = "lazygit";
      # Nix
      switch = "nh os switch";
      test = "nh os test";
      rollback = "nh os rollback";
      list-gens = "nh os info";
      nix-clean = "nh clean all";
      # Misc
      please = "sudo";
      mkdir = "mkdir -p";
      rm = "trash";
    };
    initExtra = ''
      open() { xdg-open "$@" >/dev/null 2>&1 & }
      n() { if [ "$#" -eq 0 ]; then nvim .; else nvim "$@"; fi; }
      set -o vi
      eval "$(starship init bash)"
      eval "$(zoxide init --cmd cd bash)"
    '';
  };
}
