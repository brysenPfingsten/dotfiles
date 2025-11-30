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
    devShells.${system} = {
      python = pkgs.mkShell {
        packages = with pkgs; [
          python311
          python311Packages.pip
        ];

        shellHook = ''
          if [ -d .venv ]; then
            echo "Activating existing venv (.venv)…"
            source .venv/bin/activate
          else
            echo "Creating venv in .venv…"
            python -m venv .venv
            source .venv/bin/activate
            if [ -f requirements.txt ]; then
              echo "Installing from requirements.txt…"
              pip install -r requirements.txt
            fi
          fi
        '';
      };
    };
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {inherit inputs LazyVim;};

      modules = [
        ./hosts/bronzo/configuration.nix
        ./dooit.nix

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
