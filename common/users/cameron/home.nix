{ pkgs, lib, config, osConfig, ... }:

{
  imports = [
    ./home-manager/sway.nix
    ./home-manager/hyprland.nix
    
    ./home-manager/swaylock.nix
    ./home-manager/waybar.nix
  ];

  home.username = "cameron";
  home.homeDirectory = osConfig.users.users.cameron.home;
}
