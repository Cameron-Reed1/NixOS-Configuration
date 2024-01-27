{ lib, pkgs, ... }:

with lib; {
  options = {
    defaultTerminal = mkOption {
      default = "kitty";
      type = types.str;
    };

    terminal = mkOption {
      default = "${pkgs.kitty}/bin/kitty";
      type = types.path;
    };
  };
}
