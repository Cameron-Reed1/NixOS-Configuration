{ pkgs, lib, inputs, config, osConfig, ... }:

{
  imports = [
    inputs.nix-colors.homeManagerModules.default

    ./home-manager/options.nix

    ./home-manager/sway.nix
    ./home-manager/hyprland.nix
    
    ./home-manager/hyprpaper.nix
    ./home-manager/swaylock.nix
    ./home-manager/waybar.nix

    ./home-manager/alacritty.nix
    ./home-manager/kitty.nix
    ./home-manager/zsh.nix
    ./home-manager/nvim.nix
    ./home-manager/tmux.nix
    ./home-manager/lf.nix
    ./home-manager/git.nix
  ];

  home.username = "cameron";
  home.homeDirectory = osConfig.users.users.cameron.home;

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.packages = with pkgs; [
    eza
    signal-desktop
  ];

  term = "alacritty";
}
