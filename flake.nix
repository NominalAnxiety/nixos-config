{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    
    # home-manager = {
    #   url = "github:nix-community/home-manager";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: 
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
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      austinPC = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs system; };
        # > Our main nixos configuration file <
        modules = [./hosts/austinPC/configuration.nix];
      };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
	#    homeConfigurations = {
	#      "austinb@austinPC" = home-manager.lib.homeManagerConfiguration {
	#        # Home-manager requires 'pkgs' instance
	#        pkgs = nixpkgs.legacyPackages.x86_64-linux;
	#        extraSpecialArgs = {inherit inputs;};
	#        # > Our main home-manager configuration file <
	#        modules = [ ./home-manager/home.nix ];
	# # problem is my home-manager needs to be in .config I think
	#      };
    # };
  };
}
