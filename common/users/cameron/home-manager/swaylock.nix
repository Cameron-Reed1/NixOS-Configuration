{ pkgs, lib, osConfig, ... }:

{
  programs.swaylock = {
    enable = builtins.elem "hyprland" osConfig.desktop || builtins.elem "sway" osConfig.desktop;
    settings = {
      ignore-empty-password = true;
      color = "333333";
      image = "${./other-files/wallpapers/lake.jpg}";
    };
  };
}
