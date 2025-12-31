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
    LazyVim = {
      url = "github:matadaniel/LazyVim-module";
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
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    LazyVim,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {inherit inputs LazyVim;};

      modules = [
        ./hosts/bronzo/configuration.nix
        ./dooit.nix

        {nixpkgs.config.allowUnfree = true;}
        {nixpkgs.overlays = [inputs.nur.overlays.default];}

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {inherit inputs LazyVim;};
          home-manager.users.pfingsbr = {...}: {
            imports = [
              inputs.spicetify-nix.homeManagerModules.spicetify
              ./hosts/bronzo/home.nix
            ];
          };
          home-manager.users.root = {...}: {
            imports = [./root-home.nix];
          };
        }
      ];
    };
  };
}
