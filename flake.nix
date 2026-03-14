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

    # ── Auto-detected from the current system ──
    username = builtins.getEnv "USER";
    hostname = builtins.getEnv "HOSTNAME";
    dotfilesPath = "/Users/${username}/.dotfiles";
  in {
    darwinConfigurations.${hostname} = nix-darwin.lib.darwinSystem {
      inherit system;
      specialArgs = { inherit pkgs username hostname dotfilesPath; };
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
          home-manager.backupFileExtension = "bak";
          home-manager.extraSpecialArgs = { inherit username dotfilesPath; };
          home-manager.users.${username} = import ./home;
        }
      ];
    };
  };
}
