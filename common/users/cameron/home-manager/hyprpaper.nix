{ pkgs, lib, osConfig, ... }:

{
  home.file."hyprpaper.conf" = {
    enable = builtins.elem "hyprland" osConfig.desktop;

    target = ".config/hypr/hyprpaper.conf";
    text = ''
preload = ${./wallpapers/lake.jpg}

wallpaper = ,${./wallpapers/lake.jpg}

splash = false
    '';
  };
}
