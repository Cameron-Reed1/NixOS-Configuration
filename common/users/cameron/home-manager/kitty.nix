{ pkgs, lib, config, osConfig, ... }:

{
  programs.kitty = {
    enable = (config.term == "kitty");

    settings = {
      background = "#333333";
      foreground = "#cccccc";
      background_opacity  = 0.95;
    
      editor = "nvim";
    
      update_check_interval = 0;
    };
  };

  runInTerm = if (config.term == "kitty") then "${pkgs.kitty}/bin/kitty" else lib.mkDefault "";
  runInDangerTerm = if (config.term == "kitty") then "${pkgs.kitty}/bin/kitty" else lib.mkDefault "";
}
