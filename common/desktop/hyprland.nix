{ config, pkgs, ... }:

{
  desktop = "hyprland";

  programs.hyprland.enable = true;

  environment.systemPackages = (with pkgs; [
    waybar
    dmenu
    wmenu
  ]);
  
  xdg.portal.wlr.enable = true;
}
