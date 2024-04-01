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
set-hook -g session-created 'set -F status-style "#{?#{==:#{DANGER},},bg=#262626 fg=#cccccc,bg=#e45555 fg=#000000}"'
set-hook -g window-linked 'set -F status "#{?#{==:#{session_windows},1},off,on}"'
set-hook -g window-unlinked 'set -F status "#{?#{==:#{session_windows},1},off,on}"'


set -ga terminal-overrides ",alacritty*:RGB"
    '';
  };
}
