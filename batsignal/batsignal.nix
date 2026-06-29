{pkgs, ...}: {
  home.packages = with pkgs; [
    batsignal
  ];

  services.batsignal = {
    enable = true;

    # Battery warning threshold
    extraArgs = [
      "-w" "20"      # Warning at 20%
      "-c" "10"      # Critical at 10%
      "-d" "5"       # Danger at 5%
      "-f" "95"      # Full notification at 95%
      "-D" "notify-send"
    ];
  };
}
