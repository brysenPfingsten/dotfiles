{
  description = "Bronzo Ball Legendary Nix Flake (wth is a flake?)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    LazyVim = {
      url = "github:matadaniel/LazyVim-module";
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
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {inherit inputs LazyVim;};

      modules = [
        ./hosts/bronzo/configuration.nix

        {nixpkgs.config.allowUnfree = true;}

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {inherit inputs LazyVim;};
          home-manager.users.pfingsbr = {...}: {
            imports = [./hosts/bronzo/home.nix];
          };
          home-manager.users.root = {...}: {
            imports = [./root-home.nix];
          };
        }
      ];
    };
  };
}
