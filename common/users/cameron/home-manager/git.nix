{ pkgs, lib, config, ... }:

{
    programs.git = {
        enable = true;
        
        userEmail = "cameron@cam123.dev";
        userName = "Cameron Reed";

        extraConfig = {
            init.defaultBranch = "main";
        };
    };
}
