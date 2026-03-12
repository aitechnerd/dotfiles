{
  description = "aitechnerd — macOS system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nix-darwin, home-manager, ... }: let
    # Change this if you're on Intel Mac
    system = "aarch64-darwin";
    pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };

    # ── Change these to match your machine ──
    hostname = "Sergeys-MacBook-Air";
    username = "sergeybelov";
  in {
    darwinConfigurations.${hostname} = nix-darwin.lib.darwinSystem {
      inherit system;
      specialArgs = { inherit pkgs username hostname; };
      modules = [
        ./hosts/air-m4.nix
        ./modules/system.nix
        ./modules/packages.nix
        ./modules/homebrew.nix

        # home-manager as a nix-darwin module
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit username; };
          home-manager.users.${username} = import ./home;
        }
      ];
    };
  };
}
