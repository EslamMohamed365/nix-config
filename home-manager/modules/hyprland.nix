{
  lib,
  ...
}:
let
  inherit (lib.generators) mkLuaInline;
in
{
  wayland.windowManager.hyprland = {
    enable = true;

    # Hyprland and xdg-desktop-portal-hyprland are provided by the NixOS
    # module (programs.hyprland.enable), so don't install them here.
    package = null;
    portalPackage = null;

    # Hyprland >= 0.55 uses a Lua config (writes ~/.config/hypr/hyprland.lua)
    configType = "lua";

    settings = {
      # Lua variables shared by the keybinds below.
      mod = {
        _var = "SUPER";
      };
      terminal = {
        _var = "kitty";
      };
      browser = {
        _var = "firefox";
      };
      launcher = {
        _var = "hyprlauncher";
      };

      # Environment variables
      env = [
        {
          _args = [
            "XCURSOR_SIZE"
            "24"
          ];
        }
        {
          _args = [
            "HYPRCURSOR_SIZE"
            "24"
          ];
        }
      ];

      # Look and feel. Colors come from the Stylix target (stylix.targets.hyprland)
      # so the borders/shadows keep in sync with the theme.
      config = {
        general = {
          gaps_in = 5;
          gaps_out = 12;
          border_size = 2;
          resize_on_border = true;
          allow_tearing = false;
          layout = "dwindle";
        };

        decoration = {
          rounding = 10;
          rounding_power = 2;
          active_opacity = 1.0;
          inactive_opacity = 1.0;

          shadow = {
            enabled = true;
            range = 30;
            render_power = 3;
          };

          blur = {
            enabled = true;
            size = 3;
            passes = 1;
            vibrancy = 0.1696;
          };
        };

        animations = {
          enabled = true;
        };

        input = {
          kb_layout = "us";
          follow_mouse = 1;
          numlock_by_default = true;
        };

        binds = {
          workspace_back_and_forth = true;
          allow_workspace_cycles = true;
        };

        dwindle = {
          preserve_split = true;
        };

        misc = {
          disable_hyprland_logo = true;
        };
      };

      # Curves and animations (same defaults as the generated example config)
      curve = [
        {
          _args = [
            "easeOutQuint"
            {
              type = "bezier";
              points = [
                [
                  0.23
                  1
                ]
                [
                  0.32
                  1
                ]
              ];
            }
          ];
        }
        {
          _args = [
            "easeInOutCubic"
            {
              type = "bezier";
              points = [
                [
                  0.65
                  0.05
                ]
                [
                  0.36
                  1
                ]
              ];
            }
          ];
        }
        {
          _args = [
            "linear"
            {
              type = "bezier";
              points = [
                [
                  0
                  0
                ]
                [
                  1
                  1
                ]
              ];
            }
          ];
        }
        {
          _args = [
            "almostLinear"
            {
              type = "bezier";
              points = [
                [
                  0.5
                  0.5
                ]
                [
                  0.75
                  1
                ]
              ];
            }
          ];
        }
        {
          _args = [
            "quick"
            {
              type = "bezier";
              points = [
                [
                  0.15
                  0
                ]
                [
                  0.1
                  1
                ]
              ];
            }
          ];
        }
        {
          _args = [
            "easy"
            {
              type = "spring";
              mass = 1;
              stiffness = 238.1191;
              dampening = 24.21279333;
            }
          ];
        }
      ];

      animation = [
        {
          _args = [
            {
              leaf = "global";
              enabled = true;
              speed = 10;
              bezier = "default";
            }
          ];
        }
        {
          _args = [
            {
              leaf = "border";
              enabled = true;
              speed = 5.39;
              bezier = "easeOutQuint";
            }
          ];
        }
        {
          _args = [
            {
              leaf = "windows";
              enabled = true;
              speed = 4.79;
              spring = "easy";
            }
          ];
        }
        {
          _args = [
            {
              leaf = "windowsIn";
              enabled = true;
              speed = 4.1;
              spring = "easy";
              style = "popin 87%";
            }
          ];
        }
        {
          _args = [
            {
              leaf = "windowsOut";
              enabled = true;
              speed = 1.49;
              bezier = "linear";
              style = "popin 87%";
            }
          ];
        }
        {
          _args = [
            {
              leaf = "fadeIn";
              enabled = true;
              speed = 1.73;
              bezier = "almostLinear";
            }
          ];
        }
        {
          _args = [
            {
              leaf = "fadeOut";
              enabled = true;
              speed = 1.46;
              bezier = "almostLinear";
            }
          ];
        }
        {
          _args = [
            {
              leaf = "fade";
              enabled = true;
              speed = 3.03;
              bezier = "quick";
            }
          ];
        }
        {
          _args = [
            {
              leaf = "layers";
              enabled = true;
              speed = 3.81;
              bezier = "easeOutQuint";
            }
          ];
        }
        {
          _args = [
            {
              leaf = "layersIn";
              enabled = true;
              speed = 4;
              bezier = "easeOutQuint";
              style = "fade";
            }
          ];
        }
        {
          _args = [
            {
              leaf = "layersOut";
              enabled = true;
              speed = 1.5;
              bezier = "linear";
              style = "fade";
            }
          ];
        }
        {
          _args = [
            {
              leaf = "fadeLayersIn";
              enabled = true;
              speed = 1.79;
              bezier = "almostLinear";
            }
          ];
        }
        {
          _args = [
            {
              leaf = "fadeLayersOut";
              enabled = true;
              speed = 1.39;
              bezier = "almostLinear";
            }
          ];
        }
        {
          _args = [
            {
              leaf = "workspaces";
              enabled = true;
              speed = 1.94;
              bezier = "almostLinear";
              style = "fade";
            }
          ];
        }
        {
          _args = [
            {
              leaf = "workspacesIn";
              enabled = true;
              speed = 1.21;
              bezier = "almostLinear";
              style = "fade";
            }
          ];
        }
        {
          _args = [
            {
              leaf = "workspacesOut";
              enabled = true;
              speed = 1.94;
              bezier = "almostLinear";
              style = "fade";
            }
          ];
        }
        {
          _args = [
            {
              leaf = "zoomFactor";
              enabled = true;
              speed = 7;
              bezier = "quick";
            }
          ];
        }
      ];

      gesture = [
        {
          _args = [
            {
              fingers = 3;
              direction = "horizontal";
              action = "workspace";
            }
          ];
        }
      ];

      # Application launches
      bind = [
        {
          _args = [
            (mkLuaInline "mod .. \" + RETURN\"")
            (mkLuaInline "hl.dsp.exec_cmd(terminal)")
          ];
        }
        {
          _args = [
            (mkLuaInline "mod .. \" + R\"")
            (mkLuaInline "hl.dsp.exec_cmd(launcher)")
          ];
        }
        {
          _args = [
            (mkLuaInline "mod .. \" + C\"")
            (mkLuaInline "hl.dsp.exec_cmd(browser)")
          ];
        }

        # Window management
        {
          _args = [
            (mkLuaInline "mod .. \" + Q\"")
            (mkLuaInline "hl.dsp.window.close()")
          ];
        }
        {
          _args = [
            (mkLuaInline "mod .. \" + V\"")
            (mkLuaInline "hl.dsp.window.float({ action = 'toggle' })")
          ];
        }
        {
          _args = [
            (mkLuaInline "mod .. \" + F\"")
            (mkLuaInline "hl.dsp.window.fullscreen()")
          ];
        }
        {
          _args = [
            (mkLuaInline "mod .. \" + P\"")
            (mkLuaInline "hl.dsp.window.pseudo()")
          ];
        }
        {
          _args = [
            (mkLuaInline "mod .. \" + M\"")
            (mkLuaInline "hl.dsp.exit()")
          ];
        }

        # Focus with vim keys
        {
          _args = [
            (mkLuaInline "mod .. \" + H\"")
            (mkLuaInline "hl.dsp.focus({ direction = 'l' })")
          ];
        }
        {
          _args = [
            (mkLuaInline "mod .. \" + L\"")
            (mkLuaInline "hl.dsp.focus({ direction = 'r' })")
          ];
        }
        {
          _args = [
            (mkLuaInline "mod .. \" + K\"")
            (mkLuaInline "hl.dsp.focus({ direction = 'u' })")
          ];
        }
        {
          _args = [
            (mkLuaInline "mod .. \" + J\"")
            (mkLuaInline "hl.dsp.focus({ direction = 'd' })")
          ];
        }

        # Move the focused window with mod + SHIFT + vim keys
        {
          _args = [
            (mkLuaInline "mod .. \" + SHIFT + H\"")
            (mkLuaInline "hl.dsp.window.move({ direction = 'l' })")
          ];
        }
        {
          _args = [
            (mkLuaInline "mod .. \" + SHIFT + L\"")
            (mkLuaInline "hl.dsp.window.move({ direction = 'r' })")
          ];
        }
        {
          _args = [
            (mkLuaInline "mod .. \" + SHIFT + K\"")
            (mkLuaInline "hl.dsp.window.move({ direction = 'u' })")
          ];
        }
        {
          _args = [
            (mkLuaInline "mod .. \" + SHIFT + J\"")
            (mkLuaInline "hl.dsp.window.move({ direction = 'd' })")
          ];
        }

        # Scratchpad (special workspace)
        {
          _args = [
            (mkLuaInline "mod .. \" + S\"")
            (mkLuaInline "hl.dsp.workspace.toggle_special('magic')")
          ];
        }
        {
          _args = [
            (mkLuaInline "mod .. \" + SHIFT + S\"")
            (mkLuaInline "hl.dsp.window.move({ workspace = 'special:magic' })")
          ];
        }

        # Cycle workspaces with mod + scroll
        {
          _args = [
            (mkLuaInline "mod .. \" + mouse_down\"")
            (mkLuaInline "hl.dsp.focus({ workspace = 'e+1' })")
          ];
        }
        {
          _args = [
            (mkLuaInline "mod .. \" + mouse_up\"")
            (mkLuaInline "hl.dsp.focus({ workspace = 'e-1' })")
          ];
        }

        # Move / resize with mod + mouse
        {
          _args = [
            (mkLuaInline "mod .. \" + mouse:272\"")
            (mkLuaInline "hl.dsp.window.drag()")
            { mouse = true; }
          ];
        }
        {
          _args = [
            (mkLuaInline "mod .. \" + mouse:273\"")
            (mkLuaInline "hl.dsp.window.resize()")
            { mouse = true; }
          ];
        }

        # Volume / brightness / media keys
        {
          _args = [
            "XF86AudioRaiseVolume"
            (mkLuaInline "hl.dsp.exec_cmd('wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+')")
            {
              locked = true;
              repeating = true;
            }
          ];
        }
        {
          _args = [
            "XF86AudioLowerVolume"
            (mkLuaInline "hl.dsp.exec_cmd('wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-')")
            {
              locked = true;
              repeating = true;
            }
          ];
        }
        {
          _args = [
            "XF86AudioMute"
            (mkLuaInline "hl.dsp.exec_cmd('wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle')")
            {
              locked = true;
              repeating = true;
            }
          ];
        }
        {
          _args = [
            "XF86AudioMicMute"
            (mkLuaInline "hl.dsp.exec_cmd('wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle')")
            {
              locked = true;
              repeating = true;
            }
          ];
        }
        {
          _args = [
            "XF86MonBrightnessUp"
            (mkLuaInline "hl.dsp.exec_cmd('brightnessctl -e4 -n2 set 5%+')")
            {
              locked = true;
              repeating = true;
            }
          ];
        }
        {
          _args = [
            "XF86MonBrightnessDown"
            (mkLuaInline "hl.dsp.exec_cmd('brightnessctl -e4 -n2 set 5%-')")
            {
              locked = true;
              repeating = true;
            }
          ];
        }
        {
          _args = [
            "XF86AudioNext"
            (mkLuaInline "hl.dsp.exec_cmd('playerctl next')")
            { locked = true; }
          ];
        }
        {
          _args = [
            "XF86AudioPause"
            (mkLuaInline "hl.dsp.exec_cmd('playerctl play-pause')")
            { locked = true; }
          ];
        }
        {
          _args = [
            "XF86AudioPlay"
            (mkLuaInline "hl.dsp.exec_cmd('playerctl play-pause')")
            { locked = true; }
          ];
        }
        {
          _args = [
            "XF86AudioPrev"
            (mkLuaInline "hl.dsp.exec_cmd('playerctl previous')")
            { locked = true; }
          ];
        }
      ]
      # Workspaces 1-10: mod + <n> to focus, mod + SHIFT + <n> to move there
      ++ lib.concatLists (
        lib.genList (
          i:
          let
            ws = i + 1;
            key = toString (lib.mod ws 10);
          in
          [
            {
              _args = [
                (mkLuaInline "mod .. \" + ${key}\"")
                (mkLuaInline "hl.dsp.focus({ workspace = ${toString ws} })")
              ];
            }
            {
              _args = [
                (mkLuaInline "mod .. \" + SHIFT + ${key}\"")
                (mkLuaInline "hl.dsp.window.move({ workspace = ${toString ws} })")
              ];
            }
          ]
        ) 10
      );

      window_rule = [
        # Fix some dragging issues with XWayland
        {
          match = {
            class = "^$";
            title = "^$";
            xwayland = true;
            float = true;
            fullscreen = false;
            pin = false;
          };
          no_focus = true;
        }
        # Keep browser picture-in-picture windows floating
        {
          match = {
            class = "firefox";
            title = ".*Picture in Picture.*";
          };
          float = true;
        }
      ];
    };
  };
}
