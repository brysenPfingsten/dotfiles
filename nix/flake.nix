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
    racket-langserver-src = {
      url = "github:jeapostrophe/racket-langserver?rev=a9297eddaa3f4b7689e4d1594bf5a3e44cfaaa9a";
      flake = false;
    };
    racket-formatter-src = {
      url = "github:sorawee/fmt";
      flake = false;
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    LazyVim,
    racket-langserver-src,
    racket-formatter-src,
    ...
  }: let
    system = "x86_64-linux";

    racketLSOverlay = import ./overlays/racket-langserver.nix {src = racket-langserver-src;};
    racketFMTOverlay = import ./overlays/racket-formatter.nix {src = racket-formatter-src;};
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {inherit inputs LazyVim;};

      modules = [
        ./hosts/bronzo/configuration.nix

        {nixpkgs.overlays = [racketLSOverlay racketFMTOverlay];}
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
