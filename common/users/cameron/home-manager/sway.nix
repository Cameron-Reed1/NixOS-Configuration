{ pkgs, lib, config, osConfig, ... }:

{
  config = lib.mkIf (builtins.elem "sway" osConfig.desktop) (
  let
    WOBSOCK = "$XDG_RUNTIME_DIR/wob.sock";
  in { wayland.windowManager.sway = {
    enable = true;
    config = {
      modifier = "Mod4";
      terminal = "${config.term}";

      menu = "${pkgs.dmenu}/bin/dmenu_path | ${pkgs.wmenu}/bin/wmenu -p 'Run:' -l 10 | ${pkgs.findutils}/bin/xargs swaymsg exec --";

      startup = [
        { command = "rm -f ${WOBSOCK} && mkfifo ${WOBSOCK} && tail -f ${WOBSOCK} | ${pkgs.wob}/bin/wob"; }
        { command = "swayidle -w timeout 270 'swaylock -f' timeout 300 'systemctl suspend' before-sleep 'swaylock -f; sleep 1' after-resume 'swaymsg \"output * dpms on\" &"; }
      ];

      output = {
        "*" = {
          bg = "${./other-files/wallpapers/lake.jpg} fill";
        };

        eDP-1 = {
          scale = "1.5";
        };
      };

      seat = {
        "*" = {
          xcursor_theme = "Bibata-Original-Classic";
        };
      };

      gaps = {
        inner = 2;
        outer = 2;
      };

      input = {
        "type:touchpad" = {
          dwt = "enabled";
          tap = "enabled";
          natural_scroll = "enabled";
          middle_emulation = "enabled";
        };
      };

      keybindings = (
      let
        mod = config.wayland.windowManager.sway.config.modifier;
        menu = config.wayland.windowManager.sway.config.menu;
      in lib.mkOptionDefault {
        "${mod}+c" = "mark --toggle caffeine";
        "${mod}+Return" = "exec ${config.runInTerm} ${pkgs.tmux}";
        "${mod}+n" = "exec ${pkgs.firefox}/bin/firefox";
        "${mod}+d" = "exec pkill wmenu || ${menu}";
        "${mod}+Shift+q" = "kill";
        "${mod}+Shift+e" = "exec ${./sway-scripts/logout.sh}";
        "${mod}+Escape" = "exec ${pkgs.swaylock}/bin/swaylock -f";
        "${mod}+Shift+Escape" = "exec ${pkgs.swaylock}/bin/swaylock -f && sleep 2 && systemctl suspend";
      });

      bars = [
        {
          position = "top";
  
          statusCommand = "${pkgs.i3status}/bin/i3status";
  
          colors = {
            statusline = "#ffffff";
            background = "#323232";
            inactiveWorkspace = {
              background = "#32323200";
              border = "#32323200";
              text = "#5c5c5c";
            };
          };
        }
      ];

    }; # config

    extraConfig = ''
      for_window {
          [shell="xwayland"] title_format "%title [XWayland]"
          [shell="xwayland"] border normal 2
          [window_role="pop-up"] floating enable
          [window_role="bubble"] floating enable
          [window_role="dialog"] floating enable
          [window_type="dialog"] floating enable
          [title="(?:Open|Save) (?:File|Folder|As)"] floating enable, resize set width 1030 height 710
          [class="Minecraft.*"] floating enable
          [con_mark="caffeine"] inhibit_idle title_format "%title [Caffeinated]"
      }

      bindgesture swipe:3:left workspace next
      bindgesture swipe:3:right workspace prev

      bindsym --locked XF86MonBrightnessDown exec brightnessctl set 5%- | sed -En 's/.*\(([0-9]+)%\).*/\1/p' > ${WOBSOCK}
      bindsym --locked XF86MonBrightnessUp exec brightnessctl set 5%+ | sed -En 's/.*\(([0-9]+)%\).*/\1/p' > ${WOBSOCK}
      bindsym --locked XF86AudioRaiseVolume exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1 && wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print substr($2, 3, length($2))}' > ${WOBSOCK}
      bindsym --locked XF86AudioLowerVolume exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- -l 1 && wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print substr($2, 3, length($2))}' > ${WOBSOCK}
    '';

  };
  });
}
