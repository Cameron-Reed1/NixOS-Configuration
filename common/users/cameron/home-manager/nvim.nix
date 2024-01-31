{ pkgs, lib, config, osConfig, ... }:

{
  xdg.configFile."nvim" = {
    source = ./other-files/nvim;
    recursive = true;
  };

  home.packages = with pkgs; [
    lua-language-server
    ripgrep
    neovim
  ];
}
