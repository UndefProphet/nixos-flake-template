{
  description = "A very basic flake";

  outputs = inputs@{ self, nixpkgs, ... }:
    let
      # User
      user = "username";
      location = "$HOME/.nixos";

      # Nix
      stateVersion = "24.11";

    in {
      nixosConfigurations = {

        desktop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            configName = "desktop";
            hostName = "deskman";
            inherit inputs stateVersion user location;
          };
          modules = [ ./hosts/common ./hosts/desktop];
        };

      };
    };

  inputs = {

    # Nix packages
    # A collection of over 100,000 software packages that can be installed with the Nix.
    nixpkgs = {
      type = "github";
      owner = "nixos";
      repo = "nixpkgs";
      ref = "nixos-unstable";
    };

    # https://github.com/nix-community/home-manager
    # Provides a basic system for managing a user environment.
    home-manager = {
      type = "github";
      owner = "nix-community";
      repo = "home-manager";
      ref = "master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}

