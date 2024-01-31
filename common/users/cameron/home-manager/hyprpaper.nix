{ pkgs, lib, osConfig, ... }:

{
  home.file."hyprpaper.conf" = {
    enable = builtins.elem "hyprland" osConfig.desktop;

    target = ".config/hypr/hyprpaper.conf";
    text = ''
preload = ${./other-files/wallpapers/lake.jpg}

wallpaper = ,${./other-files/wallpapers/lake.jpg}

splash = false
    '';
  };
}
