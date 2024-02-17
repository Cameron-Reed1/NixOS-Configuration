{ config, pkgs, ... }:

{
  desktop = [ "sway" ];

  programs.sway = {
    enable = true;

    extraPackages = with pkgs; [
      swaylock
      swayidle
      dmenu
      wmenu
      i3status
      brightnessctl
      wob
      imv
      mpv
    ];
  };

  xdg.portal.wlr.enable = true;
}
