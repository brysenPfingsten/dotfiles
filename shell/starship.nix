{
  programs.starship = {
    enable = true;
    enableBashIntegration = true;

    settings = {
      add_newline = false;
      command_timeout = 800;

      format =
        "[](fg:#a3aed2)"
        + "[ ](bg:#a3aed2 fg:#090c0c)"
        + "[](bg:#769ff0 fg:#a3aed2)"
        + "$directory"
        + "[](fg:#769ff0 bg:#394260)"
        + "$git_branch"
        + "$git_status"
        + "[](fg:#394260 bg:#212736)"
        + "$rust"
        + "$lua"
        + "$python"
        + "[](fg:#212736 bg:#1d2230)"
        + "$cmd_duration"
        + "[ ](fg:#1d2230)"
        + "$nix_shell"
        + "\n$character";

      character = {
        success_symbol = "[➜](fg:mauve)";
        error_symbol = "[➜](fg:mauve)";
        vimcmd_symbol = "[❮](fg:mauve)";
      };

      directory = {
        truncation_length = 3;
        truncate_to_repo = true;
        truncation_symbol = "…/";
        style = "fg:#e3e5e5 bg:#769ff0";
        format = "[ $path ]($style)";
        read_only = " ";
      };

      git_branch = {
        symbol = " ";
        style = "bg:#394260";
        format = "[[ $symbol $branch ](fg:#769ff0 bg:#394260)]($style)";
      };

      git_status = {
        style = "bg:#394260";
        format = "[[($all_status$ahead_behind )](fg:#769ff0 bg:#394260)]($style)";
        conflicted = "!";
        untracked = "?";
        modified = "*";
        staged = "+";
        renamed = "»";
        deleted = "✘";
        stashed = "$";
        ahead = "⇡";
        behind = "⇣";
        diverged = "⇕";
      };

      rust = {
        symbol = "";
        style = "bg:#212736";
        format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
      };

      lua = {
        symbol = "󰢱";
        style = "bg:#212736";
        format = "[[ $symbol ](fg:#769ff0 bg:#212736)]($style)";
      };

      python = {
        symbol = "";
        format = "[[ \${symbol} \${pyenv_prefix} (\${version} )(\($virtualenv\) )](fg:#769ff0 bg:#212736)]($style)";
      };

      nix_shell = {
        unknown_msg = "unknown";
        format = "[ via $state shell]($style) ";
      };

      cmd_duration = {
        style = "bg:#1d2230";
        format = "[[  $duration ](fg:#a0a9cb bg:#1d2230)]($style)";
      };
    };
  };
}
