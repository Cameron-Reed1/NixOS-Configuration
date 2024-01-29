{ lib, pkgs, config, osConfig, common_dir, ... }:

{
  imports = [
    (common_dir + /users/cameron/home.nix)
  ];


  home.stateVersion = "23.11";
}
