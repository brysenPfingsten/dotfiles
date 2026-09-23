{pkgs, ...}: {
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
      timeout = 0;
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
      "usbcore.autosuspend=-1"
    ];
  };

  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [2273];
      trustedInterfaces = ["tailscale0"];
      interfaces.tailscale0.allowedTCPPorts = [2273 8096];
    };
    networkmanager.enable = true;
    networkmanager.wifi.backend = "iwd";
    wireless.iwd.enable = true;
  };

  time.timeZone = "America/New_York";

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

    printing.enable = true;
    udisks2.enable = true;
    gvfs.enable = true;
    tailscale.enable = true;
    openssh.enable = true;

    pulseaudio.enable = false;
    pipewire = {
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

    postgresql = {
      enable = true;
      package = pkgs.postgresql_18;
      ensureUsers = [
        {
          name = "pfingsbr";
          ensureClauses = {
            login = true;
            createdb = true;
          };
        }
      ];
    };
  };

  security.rtkit.enable = true;

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

  users.users.pfingsbr = {
    isNormalUser = true;
    description = "Brysen";
    extraGroups = ["networkmanager" "wheel" "docker" "video" "input" "i2c"];
  };

  nixpkgs.config.allowUnfree = true;

  virtualisation.docker.enable = true;

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
    gcc
    cmake
    gnumake
  ];

  services.hardware.openrgb = {
    enable = true;
    motherboard = "amd";
  };
  hardware.i2c.enable = true;

  services.udev.packages = [pkgs.liquidctl];

  system.stateVersion = "25.05";
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    auto-optimise-store = true;
  };
}
