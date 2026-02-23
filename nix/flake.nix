{
  description = "Bronzo Ball Legendary Nix Flake (wth is a flake?)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dooit = {
      url = "github:dooit-org/dooit";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dooit-extras = {
      url = "github:dooit-org/dooit-extras";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    ...
  }: let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [
        inputs.nur.overlays.default
      ];
    };
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {inherit inputs;};

      modules = [
        ./hosts/bronzo/configuration.nix
        ./dooit.nix

        {nixpkgs.config.allowUnfree = true;}
        {nixpkgs.overlays = [inputs.nur.overlays.default];}

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {inherit inputs;};
          home-manager.users.pfingsbr = {...}: {
            imports = [
              inputs.spicetify-nix.homeManagerModules.spicetify
              inputs.catppuccin.homeModules.catppuccin
              ./hosts/bronzo/home.nix
            ];
          };
        }
      ];
    };
  };
}
