{ pkgs, ... }:

{
  programs = {
    zsh.enable = true;
    vim.defaultEditor = true;
  };

  environment.systemPackages = (with pkgs; [
    vim
    neovim
    git
    wget
    kitty
    ranger
    lf
    firefox

    greetd.tuigreet
  ]);

  environment.shells = with pkgs; [ bash zsh ];

  xdg.portal.wlr.enable = true;
  nixpkgs.config.allowUnfree = true;
}
