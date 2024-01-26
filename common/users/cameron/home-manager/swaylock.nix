{ pkgs, lib, osConfig, ... }:

{
  config = lib.mkIf (builtins.elem "hyprland" osConfig.desktop || builtins.elem "sway" osConfig.desktop)
  { programs.swaylock = {
    enable = true;
    settings = {
      ignore-empty-password = true;
      color = "333333";
      image = ./wallpapers/lake.jpg;
    };
  };
  };
}
