{
    inputs = {
        nixpks.url = "github:NixOs/nixpkgs/nixos-24.11";
        nixpkgs-unstable = "github:NixOs/nixpkgs-unstable";
        home-manager.url = "github:nix-community/home-manager/release-24.11";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
        system = "x86_64-linux";
        pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
        };
    in {
        nixosConfigurations.shogun-desktop = nixpkgs.lib.nixosSystem {
            inherit system;
            modules = [
                ./hardware-configuration.nix
                ./hosts/shogun-desktop.nix

                home-manager.nixosModules.home-manager
                {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.users.shogun = import ./home/shogun.nix;
                }
            ];
        };
    };
}