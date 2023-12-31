{ pkgs, ... }:

{
  programs = {
    sway = {
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
  };
}
