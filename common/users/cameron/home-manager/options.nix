{ lib, pkgs, ... }:

with lib; {
  options = {
    term = mkOption {
      default = "";
      type = types.enum [ "" "kitty" "alacritty" ];
    };

    runInTerm = mkOption {
      default = "";
      type = types.str;
    };
  };
}
