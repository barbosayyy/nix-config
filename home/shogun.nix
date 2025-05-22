{ config, pkgs, unstable, ... }:
{
    home.username = "shogun";
    home.homeDirectory = "/home/shogun";
    home.sessionVariables = {
        PATH = "${config.home.homeDirectory}/.local/bin:${config.home.homeDirectory}/.config/rofi/scripts";
    };

    home.packages = with pkgs; [
        obsidian
        unstable.rclone
    ];
}