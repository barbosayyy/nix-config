{ config, pkgs, unstable, hyprland, ... }:
{
    home.username = "shogun";
    home.homeDirectory = "/home/shogun";
    home.sessionVariables = {
        PATH = "${config.home.homeDirectory}/.local/bin:${config.home.homeDirectory}/.config/rofi/scripts";
    };

    home.packages = with pkgs; [
        obsidian
        unstable.rclone
        discord
        libreoffice

		kitty
    ];

    programs.hyprland = {
		enable = true;
		xwayland.enable = true;
        enableNvidiaPatches = true;
	};

    programs.kitty.enable = true;

    xdg.configFile."hypr/hyprland.conf".source = ./hypr/hyprland.conf;

    services.dunst.enable = true;
    services.cliphist.enable = true;

    home.stateVersion = "24.11";
}
