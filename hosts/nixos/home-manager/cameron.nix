{ lib, pkgs, inputs, config, osConfig, ... }:

{
  imports = [
    (inputs.common_dir + /users/cameron/home.nix)
  ];

  colorScheme = inputs.nix-colors.colorSchemes.framer;


  home.stateVersion = "24.05";
}
