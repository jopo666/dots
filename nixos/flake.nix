{
  description = "Flake configurations for different systems/homes";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    # NixOS configuration entrypoint(s).
    #  'nixos-rebuild --flake .#HOSTNAME'
    nixosConfigurations = {
      thinkpad = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        system = "x86_64-linux";
        modules = [
          ./thinkpad-config.nix
        ];
      };
    };
  };
}
