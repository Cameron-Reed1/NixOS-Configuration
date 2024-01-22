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
    ];
  };

  xdg.portal.wlr.enable = true;

  services.xserver.displayManager.sessionPackages = [ config.programs.sway.package ];
}
