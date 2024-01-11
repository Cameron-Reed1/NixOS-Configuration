{ config, pkgs, ... }:

{
  login-manager = "gdm";

  services.xserver.displayManager.gdm.enable = true;

}
