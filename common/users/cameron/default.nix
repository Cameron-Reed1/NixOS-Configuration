{ config, lib, pkgs, ... }:

with lib; let
  cfg = config.user.cameron;
in {
  options.user.cameron = {
    enable = mkEnableOption "user cameron";
  };

  config = mkIf cfg.enable {
    users = {
      groups.cameron.gid = 1000;

      users.cameron = {
        description = "Cameron";
        isNormalUser = true;

        uid = 1000;
        group = "cameron";
        extraGroups = [ "wheel" ] ++
          (lib.optionals config.networking.networkmanager.enable [ "networkmanager" ]);

        home = "/home/cameron-nix";
        createHome = true;

        shell = pkgs.zsh;
        packages = (with pkgs; [
          direnv
          nix-direnv
          bibata-cursors
          bibata-cursors-translucent
        ]) ++ (with pkgs.gnomeExtensions; [
          gsconnect
          dock-from-dash
        ]);
      };
    };
  };
}
