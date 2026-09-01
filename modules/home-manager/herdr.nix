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

        # Vim-style pane movement (direct, no prefix)
        focus_pane_left = "alt+h";
        focus_pane_down = "alt+j";
        focus_pane_up = "alt+k";
        focus_pane_right = "alt+l";

        # Vim-style tab switching
        switch_tab = "alt+1..9";
        previous_tab = "shift+left";
        next_tab = "shift+right";

        # tmux-style last pane (prefix+prefix)
        last_pane = "prefix+a";

        # Match tmux: | splits side-by-side, - splits stacked
        split_vertical = "prefix+|";
        split_horizontal = "prefix+-";

        # Navigate mode (prefix+w): vim-style j/k workspaces, ctrl+j/k panes
        navigate_workspace_up = "k";
        navigate_workspace_down = "j";
        navigate_pane_up = "ctrl+k";
        navigate_pane_down = "ctrl+j";

        # Keyboard-driven workspace/agent switching
        switch_workspace = "prefix+shift+1..9";
        focus_agent = "prefix+alt+1..9";

        # Custom commands — everything reachable without the mouse
        command = [
          {
            key = "prefix+alt+g";
            type = "popup";
            command = "lazygit";
            description = "lazygit";
            width = "80%";
            height = "80%";
          }
          {
            key = "prefix+t";
            type = "popup";
            command = "exec \"\${SHELL:-sh}\"";
            description = "scratch terminal";
            width = "80%";
            height = "80%";
          }
        ];
      };

      ui = {
        tab_bar_position = "bottom";
        toast.delivery = "system";
      };
    };
  };
}