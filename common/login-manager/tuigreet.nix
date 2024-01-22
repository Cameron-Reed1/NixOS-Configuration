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
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember-user-session";
        user = "greeter";
      };
    };
  };
}
