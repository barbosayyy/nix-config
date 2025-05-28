{
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
        nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
        home-manager.url = "github:nix-community/home-manager/release-24.11";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";
        hyprland.url = "github:hyprwm/Hyprland";
    };

    outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, hyprland, ... }@inputs:
    let
        system = "x86_64-linux";
        pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
            config.allowUnsupportedSystem = true;
        };

        unstable = import nixpkgs-unstable {
            inherit system;
            config.allowUnfree = true;
        };
    in {
        nixosConfigurations.shogun-desktop = nixpkgs.lib.nixosSystem {
            inherit system;
            inherit pkgs;
            modules = [
                ./hardware-configuration.nix
                ./hosts/shogun-desktop.nix
                hyprland.nixosModules.default
                home-manager.nixosModules.home-manager
                {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.users.shogun = import ./home/shogun/shogun.nix;
                    home-manager.extraSpecialArgs = {
                        inherit pkgs;
                        inherit inputs;
                    };
                }
            ];
        };
    };
}
