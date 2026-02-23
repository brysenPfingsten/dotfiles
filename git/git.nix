{pkgs, ...}: {
  programs = {
    git = {
      enable = true;
      settings = {
        user = {
          name = "Brysen Pfingsten";
          email = "brysen.pfingsten@gmail.com";
        };
        init.defaultBranch = "main";
        pull.rebase = true;
        credential.helper = "!${pkgs.gh} auth git-credential";
        diff.tool = "difft";
      };
    };
    gh = {
      enable = true;
      gitCredentialHelper.enable = true;
    };
  };
  home.packages = with pkgs; [
    lazygit
  ];
}
