{ config, pkgs, ... }:

{
  login-manager = "tuigreet";

  environment.systemPackages = (with pkgs; [
    greetd.tuigreet
  ]);

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --remember-user-session --sessions ${config.services.displayManager.sessionData.desktops}/share/wayland-sessions";
        user = "greeter";
      };
    };
  };
}
