{ pkgs, ... }:

{
  users = {
    defaultUserShell = pkgs.bash;
  };

  imports = [
    ./cameron.nix
  ];
}
