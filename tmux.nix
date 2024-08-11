{ config, lib, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    historyLimit = 100000;
    plugins = with pkgs; [
      tmuxPlugins.better-mouse-mode
      {
        plugin = tmuxPlugins.catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavour 'mocha'
          set -g @catppuccin_window_tabs_enabled on
          set -g @catppuccin_date_time "%H:%M"

          set -g @catppuccin_window_left_separator ""
          set -g @catppuccin_window_right_separator " "
          set -g @catppuccin_window_middle_separator " █"
          set -g @catppuccin_window_number_position "right"

          set -g @catppuccin_window_default_fill "number"
          set -g @catppuccin_window_default_text "#W"

          set -g @catppuccin_window_current_fill "number"
          set -g @catppuccin_window_current_text "#W"

          set -g @catppuccin_status_modules_right "host session"
          set -g @catppuccin_status_left_separator  " "
          set -g @catppuccin_status_right_separator ""
          set -g @catppuccin_status_fill "icon"
          set -g @catppuccin_status_connect_separator "no"

          set -g @catppuccin_directory_text "#{pane_current_path}"
        '';
      }
    ];
    extraConfig = ''
      # bind CTRL+B,R to reload the tmux config
      unbind r
      bind r source-file ~/.config/tmux/tmux.conf
      bind -n C-k clear-history

      # enable mouse control
      set -g mouse on

      # move the status bar to the top
      set-option -g status-position top

      # make sure that windows and panes start from 1 not 0
      set -g base-index 1
      setw -g pane-base-index 1
    '';
  };
}
