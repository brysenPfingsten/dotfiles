{pkgs, ...}: {
  home.packages = with pkgs; [
    libnotify
  ];

  services.mako = {
    enable = true;

    settings = {
      default-timeout = 5000;
      border-size = 2;
      border-radius = 6;
      padding = "10";
      margin = "10";
      anchor = "top-right";
      layer = "top";
      background-color = "#1F1F1FDD";
      text-color = "#FFFFFFFF";
      font = "JetBrains Mono Nerd";
    };
  };
}
