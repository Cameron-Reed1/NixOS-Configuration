{ pkgs, lib, inputs, config, osConfig, ... }:

{
  programs.tmux = {
    enable = true;

    terminal = "tmux-256color";
    keyMode = "vi";
    mouse = true;

    sensibleOnTop = false;

    extraConfig = ''
set -g prefix C-a
set -g prefix2 C-k


set -g status-right '"#T"'
set -g status-style 'bg=#262626 fg=#cccccc'
set-hook -g window-linked 'set -F status "#{?#{==:#{session_windows},1},off,on}"'
set-hook -g window-unlinked 'set -F status "#{?#{==:#{session_windows},1},off,on}"'


set -ga terminal-overrides ",*:Tc"
    '';
  };
}
