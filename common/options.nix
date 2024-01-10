{ lib, ... }:

with lib; {
  options = {
    desktop = mkOption {
      default = "";
      type = types.str;
    };
  };
}
