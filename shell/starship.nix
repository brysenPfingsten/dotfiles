{...}: {
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    settings = {
      add_newline = false;
      command_timeout = 800;

      format = "$directory$git_branch$git_status$nodejs$python$rust$golang$deno$cmd_duration$line_break$character";

      # Directory
      directory = {
        truncation_length = 3;
        truncate_to_repo = true;
        style = "bold blue";
        read_only = " ";
      };

      # Git
      git_branch = {
        symbol = " ";
        style = "bold purple";
        format = " [$symbol$branch]($style)";
      };

      git_status = {
        style = "bold yellow";
        format = " [$all_status$ahead_behind]($style)";
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

      # Only shows when non-trivial
      cmd_duration = {
        min_time = 1200;
        format = " [⏱ $duration]($style)";
        style = "dimmed white";
      };

      # Languages (only appear in relevant projects)
      nodejs = {
        symbol = "󰎙 ";
        format = " [$symbol($version)]($style)";
        style = "green";
      };

      python = {
        symbol = "󰌠 ";
        format = " [$symbol($version)]($style)";
        style = "yellow";
        pyenv_version_name = true;
      };

      rust = {
        symbol = "󱘗 ";
        format = " [$symbol($version)]($style)";
        style = "red";
      };

      golang = {
        symbol = "󰟓 ";
        format = " [$symbol($version)]($style)";
        style = "cyan";
      };

      deno = {
        symbol = "🦕 ";
        format = " [$symbol($version)]($style)";
        style = "bright-green";
      };

      # Prompt character
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
        vimcmd_symbol = "[❮](bold yellow)";
      };
    };
  };
}
# add_newline = true
# command_timeout = 200
# format = "[$directory$git_branch$git_status]($style)$character"
#
# [character]
# error_symbol = "[✗](bold cyan)"
# success_symbol = "[❯](bold cyan)"
#
# [directory]
# truncation_length = 2
# truncation_symbol = "…/"
# repo_root_style = "bold cyan"
# repo_root_format = "[$repo_root]($repo_root_style)[$path]($style)[$read_only]($read_only_style) "
#
# [git_branch]
# format = "[$branch]($style) "
# style = "italic cyan"
#
# [git_status]
# format     = '[$all_status]($style)'
# style      = "cyan"
# ahead      = "⇡${count} "
# diverged   = "⇕⇡${ahead_count}⇣${behind_count} "
# behind     = "⇣${count} "
# conflicted = " "
# up_to_date = " "
# untracked  = "? "
# modified   = " "
# stashed    = ""
# staged     = ""
# renamed    = ""
# deleted    = ""

