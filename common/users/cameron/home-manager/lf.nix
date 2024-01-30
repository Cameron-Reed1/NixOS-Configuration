{ pkgs, lib, inputs, config, osConfig, ... }:

{
  programs.lf = {
    enable = builtins.elem pkgs.lf osConfig.environment.systemPackages;

    commands = {
      delete = ''''${{
        set -f
        printf "$fx\n"
        printf "delete? [y/N] "
        read ans
        [ "$ans" = "y" ] && rm -rf $fx
      }}'';
    };

    keybindings = {
      x = "delete";
      "<delete>" = "delete";
      "<enter>" = "open";
    };

    settings = {
      scrolloff = 8;
      preview = true;
      drawbox = true;
      icons = true;
      cursorpreviewfmt = "\033[7;90m";
    };
  };

  xdg.configFile."lf/icons" = {
    enable = builtins.elem pkgs.lf osConfig.environment.systemPackages;

    source = "${inputs.lf-icons}/etc/icons.example";
  };
}
