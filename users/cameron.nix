{ pkgs, ... }:

{
  users = {
    groups.cameron.gid = 1000;

    users.cameron = {
      description = "Cameron";
      isNormalUser = true;

      uid = 1000;
      group = "cameron";
      extraGroups = [ "networkmanager" "wheel" ];

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
}
