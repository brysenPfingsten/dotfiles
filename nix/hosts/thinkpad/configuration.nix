{...}: {
  imports = [
    ./hardware-configuration.nix
    ../../common/configuration.nix
  ];

  networking.hostName = "thinkpad";

  # Laptop power management
  services.tlp.enable = true;
  powerManagement = {
    cpuFreqGovernor = "powersave";
    powertop.enable = true;
  };

  # ThinkPad fingerprint reader
  services.fprintd.enable = true;
  security.pam.services.hyprlock.fprintAuth = true;
  security.pam.services.ly.fprintAuth = false;
  security.pam.services.sudo.fprintAuth = false;
}
