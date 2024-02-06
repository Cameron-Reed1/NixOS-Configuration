{ pkgs, lib, inputs, config, osConfig, ... }:

{
  programs.alacritty = {
    enable = (config.term == "alacritty");
    
    settings = {
      window = {
        opacity = 0.95;
        dynamic_padding = true;
      };

      colors.primary = {
        foreground = "#cccccc";
        background = "#333333";
      };

      cursor = {
        style.blinking = "On";
        blink_interval = 500;
        blink_timeout = 15;
      };

      mouse = {
        hide_when_typing = true;
      };
    };
  };

  runInTerm = if (config.term == "alacritty") then "${pkgs.alacritty}/bin/alacritty -e" else lib.mkDefault "";
}
