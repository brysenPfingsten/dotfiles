{...}: {
  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
  };
  home.file.".bashrc".source = ./bashrc;
}
