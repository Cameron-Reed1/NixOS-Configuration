{ pkgs, ... }:

{
  users = {
    defaultUserShell = pkgs.bash;
  };

  imports = [
    ./cameron/default.nix
  ];
}
