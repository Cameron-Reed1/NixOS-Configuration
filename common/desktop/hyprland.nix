{ config, pkgs, ... }:

{
  desktop = [ "hyprland" ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.systemPackages = (with pkgs; [
    waybar
    dmenu
    wmenu
    swaylock
    swayidle
  ]);
}
