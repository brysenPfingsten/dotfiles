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
  security.pam.services.hyprlock.fprintAuth = true;
}
