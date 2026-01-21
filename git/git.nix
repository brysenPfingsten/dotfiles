{
  config,
  pkgs,
  ...
}: {
  programs = {
    git = {
      enable = true;
      userName = "Brysen Pfingsten";
      userEmail = "brysen.pfingsten@gmail.com";
      extraConfig = {
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
# user.name = "brysenPfingsten";
# user.email = "brysen.pfingsten@gmail.com";
# settings = {

