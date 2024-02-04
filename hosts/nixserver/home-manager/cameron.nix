{ lib, pkgs, inputs, config, osConfig, ... }:

{
  imports = [
    (inputs.common_dir + /users/cameron/home.nix)
  ];

  colorScheme = inputs.nix-colors.colorSchemes.dracula;


  home.stateVersion = "23.11";
}
