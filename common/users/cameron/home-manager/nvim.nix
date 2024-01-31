{ pkgs, lib, config, osConfig, inputs, ... }:

{
  xdg.configFile."nvim" = {
    source = inputs.nvim-config;
    recursive = true;
  };

  home.packages = with pkgs; [
    lua-language-server
    ripgrep
    neovim
  ];
}
