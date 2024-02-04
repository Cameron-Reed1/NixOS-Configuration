{ pkgs, lib, osConfig, ... }:

{
  programs.kitty = {
    enable = (builtins.length osConfig.desktop) != 0;

    settings = {
      background = "#333333";
      foreground = "#cccccc";
      background_opacity  = 0.95;
    
      editor = "nvim";
    
      update_check_interval = 0;
    };
  };
}
