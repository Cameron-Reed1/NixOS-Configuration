{ lib, pkgs, osConfig, ... }:

let common_dir = ../../../common;
in {
  imports = [
    (common_dir + /users/cameron/home.nix)
  ];


  home.stateVersion = "24.05";
}
