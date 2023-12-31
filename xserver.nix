{ pkgs, ... }:

{
  services.xserver = {
    # Disable X11. Don't need it with tuigreet and sway
    enable = false;

    layout = "us";
    libinput = {
      touchpad = {
        tapping = true;
      };
    };

    # I don't need xterm
    excludePackages = [ pkgs.xterm ];
  };
}
