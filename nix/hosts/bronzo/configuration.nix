{pkgs, ...}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];
  hardware.bluetooth = {
    enable = true;
    settings.General = {
      Enable = "Source,Sink,Media,Socket";
    };
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    plymouth = {
      enable = true;
      theme = "rings";
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override {
          selected_themes = ["rings"];
        })
      ];
    };

    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "udev.log_level=3"
      "systemd.show_status=auto"
      "usbcore.autosuspend=-1" # Helps keep mouse awake
    ];
    loader.timeout = 0;
  };

  networking = {
    hostName = "nixos";

    firewall = {
      enable = true;
      allowedTCPPorts = [2273];
      trustedInterfaces = ["tailscale0"];
      interfaces.tailscale0.allowedTCPPorts = [2273];
    };
  };

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

    # Tailscale
    tailscale.enable = true;

    # SSH
    openssh = {
      enable = true;
    };
  };

  security.pam.services.hyprlock.fprintAuth = true;

  powerManagement = {
    cpuFreqGovernor = "powersave";
    powertop.enable = true;
  };

  programs = {
    xwayland.enable = true;
    niri.enable = true;
    firefox.enable = true;
    nix-ld.enable = true;
    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep 3";
      flake = "/home/pfingsbr/dotfiles/nix";
    };
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
      };
    };
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.pfingsbr = {
    isNormalUser = true;
    description = "Brysen";
    extraGroups = ["networkmanager" "wheel" "docker" "video" "input"];
  };

  nixpkgs.config.allowUnfree = true;

  virtualisation.docker = {
    enable = true;
  };

  fonts = {
    fontconfig.enable = true;
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code
      maple-mono.NF
    ];
  };

  environment.systemPackages = with pkgs; [
    xits-math
    fuzzel

    # toolchain for native-compiled plugins
    gcc
    cmake
    gnumake
  ];

  system.stateVersion = "25.05";
  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
    };
  };
}
