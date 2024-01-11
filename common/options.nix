{ lib, ... }:

with lib; {
  options = {
    login-manager = mkOption {
      default = "";
      type = types.str;
    };

    desktop = mkOption {
      default = "";
      type = types.str;
    };
  };
}
