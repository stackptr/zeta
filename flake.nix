{
  description = "Flake for zeta configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    agenix.url = "github:ryantm/agenix";
  };

  outputs = { nixpkgs, agenix, ... }:
  let
    system = "aarch64-linux";
    # overlays = [ agenix.overlay ];

    pkgs = import nixpkgs {
      inherit system;
      config = { 
        # allowUnfree = true;
      };
    };
    lib = nixpkgs.lib;
  in {
    nixosConfigurations.zeta = lib.nixosSystem {
      inherit system;
      modules = [
        ./configuration.nix
        agenix.nixosModules.default
      ];
    };
  };
}
