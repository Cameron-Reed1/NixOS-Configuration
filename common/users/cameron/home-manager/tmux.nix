{ pkgs, lib, inputs, config, osConfig, ... }:

{
  programs.tmux = {
    enable = true;

    terminal = "tmux-256color";
    keyMode = "vi";
    mouse = true;
    prefix = "C-a";
    escapeTime = 1;

    sensibleOnTop = false;

    extraConfig = ''
set -g status-right '"#T"'
set -g status-style 'bg=#262626 fg=#cccccc'
set-hook -g window-linked 'set -F status "#{?#{==:#{session_windows},1},off,on}"'
set-hook -g window-unlinked 'set -F status "#{?#{==:#{session_windows},1},off,on}"'


set -ga terminal-overrides ",alacritty*:RGB"
    '';
  };
}
