{ pkgs, services, ... }:

let
  common_dir = ../../common;
  forge = pkgs.callPackage (common_dir + /custom-packages/forge-installer/forge.nix) {};

in {
  services.minecraft-server = {
    enable = true;
    eula = true;

    package = forge;
   
    jvmOpts = "-Xms8G -Xmx24G";
    declarative = true;
    serverProperties = {
      difficulty = "hard";
      gamemode = "survival";
      level-name = "vh";
      motd = "Let's vault!";
      view-distance = 12;
      enable-rcon = true;
      "rcon.password" = "d3u@@bdvVuVq9fgL#r10iFbJA";
      spawn-protection = 0;
    };

    openFirewall = true;
  };
}
