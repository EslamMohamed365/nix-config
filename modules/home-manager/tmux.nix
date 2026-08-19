{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    shortcut = "a";
    baseIndex = 1;
    keyMode = "vi";
    mouse = true;
    escapeTime = 0;
    terminal = "tmux-256color";
    focusEvents = true;
    clock24 = true;
    customPaneNavigationAndResize = true;

    extraConfig = ''
      set -ga terminal-overrides ",*:RGB"
      set -g set-clipboard on
      set -g renumber-windows on

      unbind %
      bind | split-window -h -c "#{pane_current_path}"
      unbind '"'
      bind - split-window -v -c "#{pane_current_path}"

      bind -n M-h select-pane -L
      bind -n M-j select-pane -D
      bind -n M-k select-pane -U
      bind -n M-l select-pane -R

      bind -n M-1 select-window -t 1
      bind -n M-2 select-window -t 2
      bind -n M-3 select-window -t 3
      bind -n M-4 select-window -t 4
      bind -n M-5 select-window -t 5
      bind -n M-6 select-window -t 6
      bind -n M-7 select-window -t 7
      bind -n M-8 select-window -t 8
      bind -n M-9 select-window -t 9

      bind -n S-Left previous-window
      bind -n S-Right next-window

      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
      unbind -T copy-mode-vi MouseDragEnd1Pane

      set -g status-style bg=default
      set -g status-justify left
      set -g status-left-length 40
      set -g status-right-length 80

      set -g status-left "#[bold][#S] "
      set -g status-right "#{?client_prefix,#[reverse] PREFIX #[noreverse] ,}%H:%M | %d-%b"
      set -g window-status-current-format "#[bold]● #I:#W"
      set -g window-status-format "○ #I:#W"
      set -g window-status-separator "  "

      set -g pane-border-style fg=color240
      set -g pane-active-border-style fg=white
    '';
  };
}