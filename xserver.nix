{ pkgs, ... }:

{
  services.xserver = {
    # Enable X11. GDM won't launch without it
    enable = true;

    layout = "us";
    libinput = {
      touchpad = {
        tapping = true;
      };
    };

    # Enable GNOME and its display manager, GDM
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;

    # I don't need xterm
    excludePackages = [ pkgs.xterm ];
  };
}
