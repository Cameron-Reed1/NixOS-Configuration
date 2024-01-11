{ config, pkgs, ... }:

{
  login-manager = "sddm";

  services.xserver.displayManager.sddm = {
    enable = true;
    
    autoNumlock = true;
    enableHidpi = true;
    wayland.enable = true;
  };
}
