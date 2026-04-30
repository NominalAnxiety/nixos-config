{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    better-blur = {
      url = "github:xarblu/kwin-effects-better-blur-dx";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, stylix, better-blur, ... }@inputs: 
  let 
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };
  in {
    # NixOS configuration entrypoint
    nixosConfigurations = {
      PC = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs system; };
        # > Our main nixos configuration file <
        modules = [
          ./hosts/PC/configuration.nix
          stylix.nixosModules.stylix
        ];
      };
    };
  };
}
