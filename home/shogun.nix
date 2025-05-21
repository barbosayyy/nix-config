{ config, pkgs, ... }:
{
    home.username = "shogun";
    home.homeDirectory = "/home/shogun";

    home.packages = with pkgs; [
        zsh
    ];

    programs.zsh.enable = true;
}