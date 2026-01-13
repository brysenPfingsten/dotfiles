{
  description = "Dev shell for waybar scripts deps (bluetoothctl, nmcli, brightnessctl, fzf, pipewire tools, nerd font)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
  in {
    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs; [
        # bluetoothctl + tools
        bluez

        # brightness control
        brightnessctl

        # fuzzy finder
        fzf

        # nmcli
        networkmanager

        # pipewire pulse compatibility (for client libs/tools)
        pipewire

        # nerd font (Commit Mono)
        nerd-fonts.commit-mono
      ];

      shellHook = ''
        echo "Waybar deps shell loaded."
        echo "bluetoothctl: $(command -v bluetoothctl || echo missing)"
        echo "nmcli:        $(command -v nmcli || echo missing)"
        echo "brightnessctl:$(command -v brightnessctl || echo missing)"
        echo "fzf:          $(command -v fzf || echo missing)"
      '';
    };
  };
}
