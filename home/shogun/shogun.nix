{ config, pkgs, unstable, ... }:
{
    home.username = "shogun";
    home.homeDirectory = "/home/shogun";
    home.sessionVariables = {
        PATH = "${config.home.homeDirectory}/.local/bin:${config.home.homeDirectory}/.config/rofi/scripts";
    };

    home.packages = with pkgs; [
        gnome-tweaks
        obsidian
        unstable.rclone
        discord
        libreoffice
    ];

    wayland.windowManager.hyprland = {
        #extraConfig = builtins.readFile ./hypr/hyprland.conf;
    };

    #services.dunst.enable = true;
    #services.cliphist.enable = true;

    home.stateVersion = "24.11";
}
