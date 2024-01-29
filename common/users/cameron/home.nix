{ pkgs, lib, config, osConfig, ... }:

{
  imports = [
    ./home-manager/options.nix

    ./home-manager/sway.nix
    ./home-manager/hyprland.nix
    
    ./home-manager/hyprpaper.nix
    ./home-manager/swaylock.nix
    ./home-manager/waybar.nix

    ./home-manager/zsh.nix
  ];

  home.username = "cameron";
  home.homeDirectory = osConfig.users.users.cameron.home;
}
