{
  programs.herdr = {
    enable = true;
    settings = {
      # Skip first-run interactive setup
      onboarding = false;

      # Nix manages the package — no background update/manifest checks
      update = {
        version_check = false;
        manifest_check = false;
      };

      # Explicit: no pane screen history (can contain secrets), resume agents
      experimental.pane_history = false;
      session.resume_agents_on_restore = true;

      # Explicit theme and shell
      theme.name = "gruvbox";
      terminal.default_shell = "zsh";

      keys = {
        prefix = "ctrl+a";
        focus_pane_left = "alt+h";
        focus_pane_down = "alt+j";
        focus_pane_up = "alt+k";
        focus_pane_right = "alt+l";
        switch_tab = "alt+1..9";
        previous_tab = "shift+left";
        next_tab = "shift+right";
        split_vertical = "prefix+bar";
        split_horizontal = "prefix+minus";
      };

      ui = {
        tab_bar_position = "bottom";
        tab_bar_right = [
          {type = "hostname";}
          {
            type = "datetime";
            format = "%H:%M | %d-%b";
          }
        ];
        tab_bar_right_separator = "  ";
        toast.delivery = "herdr";
      };
    };
  };
}
