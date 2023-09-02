{ pkgs, ... }:

{
  programs = {
    zsh.enable = true;
    vim.defaultEditor = true;

    sway = {
      enable = true;

      extraPackages = with pkgs; [
        swaylock
        swayidle
        dmenu
        wmenu
        i3status
        brightnessctl
        wob
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    vim
    git
    wget
    kitty
    ranger
    firefox
    gnome.gnome-tweaks
  ];

  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-console
    epiphany
    gnome.geary
  ];

  environment.shells = with pkgs; [ bash zsh ];

  xdg.portal.wlr.enable = true;
  nixpkgs.config.allowUnfree = true;
}
