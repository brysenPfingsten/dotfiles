# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];
  hardware.bluetooth.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking with iwd
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.backend = "iwd";
  networking.wireless.iwd.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  boot.kernelParams = ["usbcore.autosuspend=-1"];

  services = {
    # Enable the X11 windowing system.
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "";
        options = "caps:swapescape";
      };
    };

    seatd.enable = true;

    # Fprintd
    fprintd.enable = true;
    fprintd.tod.enable = true;
    fprintd.tod.driver = pkgs.libfprint-2-tod1-goodix;

    # Enable the GNOME Desktop Environment.
    # displayManager.gdm.enable = true;
    # desktopManager.gnome.enable = true;
    displayManager.ly = {
      enable = true;
      x11Support = false;
      settings = {
        animation = "gameoflife";
        gameoflife_entropy_interval = 10;
        gameoflife_fg = "0x010000FF";
        fg = "0x010000FF";
        gameoflife_frame_delay = 6;
        gameoflife_initial_density = 0.4;
        bigclock = "en";
        bigclock_12hr = true;
        clear_password = true;
      };
    };

    # Enable CUPS to print documents.
    printing.enable = true;

    # Trash/mounts for Nautilus
    udisks2.enable = true;
    gvfs.enable = true;

    # Power Management
    tlp.enable = true;
  };

  systemd.services.fprintd = {
    wantedBy = ["multi-user.target"];
    serviceConfig.Type = "simple";
  };

  powerManagement = {
    cpuFreqGovernor = "powersave";
    powertop.enable = true;
  };

  programs = {
    # Backlight control + permissions
    light.enable = true;
    # XWayland
    xwayland.enable = true;
    # Niri
    niri.enable = true;
    # Install firefox.
    firefox.enable = true;
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    wireplumber.extraConfig.bluetoothEnhancements = {
      "monitor.bluez.properties" = {
        "bluez5.enable-sbc-xq" = true;
        "bluez5.enable-msbc" = true;
        "bluez5.enable-hw-volume" = true;
        "bluez5.roles" = ["hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag"];
      };
    };
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  users.users.pfingsbr = {
    isNormalUser = true;
    description = "Brysen";
    extraGroups = ["networkmanager" "wheel" "docker" "video" "input"];
    packages = with pkgs; [
      #  thunderbird
    ];
  };

  nixpkgs.config.allowUnfree = true;

  virtualisation.docker = {
    enable = true;
  };

  # Optional: enable fontconfig (helps apps like VSCode, terminals, etc.)
  fonts = {
    fontconfig.enable = true;
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
    ];
  };

  environment.systemPackages = with pkgs; [
    texlive.combined.scheme-full
    xits-math

    fuzzel

    # toolchain for native-compiled plugins
    gcc
    cmake
    gnumake
    spotify
    (writeShellScriptBin "spotify" ''
      exec ${pkgs.spotify}/bin/spotify \
        --enable-features=UseOzonePlatform \
        --ozone-platform=wayland "$@"
    '')
  ];

  system.stateVersion = "25.05";
  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete older-than 7d";
    };
  };
}
