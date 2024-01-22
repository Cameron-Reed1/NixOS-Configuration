{ pkgs, lib, osConfig, ... }:

{
  config = lib.mkIf (builtins.elem "hyprland" osConfig.desktops) (
  let startup = pkgs.writeShellScript "startup.sh" ''
    hyprctl setcursor Bibata-Original-Classic 24
    waybar &

    swayidle -w \
      timeout 270 'swaylock -f' \
      timeout 300 'hyprctl dispatch dpms off' \
      before-sleep 'swaylock -f; sleep 1' \
      after-resume 'hyprctl dispatch dpms on' &
  '';
  in { wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      "$mod" = "SUPER";
      "$term" = "kitty";
      "$browser" = "firefox";
      "$menu" = "dmenu_path | wmenu -p 'Run:' -l 10 | xargs hyprctl dispatch exec";
      

      exec-once = startup;
      
      monitor = [
        ",preferred,auto,1"
        "eDP-1,preferred,0x0,1.5"
      ];

      env = [
        "XCURSOR_SIZE,24"
        "DEFAULT_TERM,$term"
      ];

      input = {
        kb_layout = "us";
        numlock_by_default = true;
        accel_profile = "flat";
        scroll_method = "2fg";
        follow_mouse = 2;
        
        touchpad = {
          natural_scroll = true;
          tap-to-click = true;
        };
      };

      general = {
        gaps_in = 2;
        gaps_out = 2;
        border_size = 2;

        "col.active_border" = "rgba(00aaffee) rgba(00ffffee) -45deg";
        "col.inactive_border" = "rgba(595959aa)";

        layout = "dwindle";
      };

      decoration = {
        rounding = 2;
        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
        "col.shadow" = "rgba(1a1a1aee)";

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          new_optimizations = true;
        };
      };

      animations = {
        enabled = true;

        bezier = [
          "myBezier, 0.05, 0.9, 0.1, 1.05"
        ];

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_is_master = true;
      };

      gestures = {
        workspace_swipe = "on";
      };

      misc = {
        force_default_wallpaper = 0;
      };

      windowrulev2 = [
        "nomaximizerequest, class:.*"
      ];

      bindr = [
        "$mod, SUPER_L, exec, pkill wmenu || $menu"
        "$mod SHIFT, E, exec, ${./hypr-scripts/logout.sh}"

        "$mod, Escape, exec, swaylock"
        "$mod SHIFT, Escape, exec, swaylock -f && sleep 2 && hyprctl dispatch dpms off"
      ];

      bind = [
        "$mod, Return, exec, $term"
        "$mod, B, exec, $browser"
        "$mod, E, killactive,"

        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
        
        "$mod, H, movefocus, l"
        "$mod, L, movefocus, r"
        "$mod, K, movefocus, u"
        "$mod, J, movefocus, d"
        
        "$mod SHIFT, left, movewindow, l"
        "$mod SHIFT, right, movewindow, r"
        "$mod SHIFT, up, movewindow, u"
        "$mod SHIFT, down, movewindow, d"
        
        "$mod SHIFT, H, movewindow, l"
        "$mod SHIFT, L, movewindow, r"
        "$mod SHIFT, K, movewindow, u"
        "$mod SHIFT, J, movewindow, d"
      ] ++ (
        # workspaces
        # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
        builtins.concatLists (builtins.genList (
          x: let
            ws = let
              c = (x + 1) / 10; # (This is integer division)
            in
              builtins.toString (x + 1 - (c * 10));
          in [
            "$mod, ${ws}, workspace, ${toString (x + 1)}"
            "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
          ]
        )
        10)
      );

    }; # settings
  };});
}
