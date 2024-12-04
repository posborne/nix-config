{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    extraConfig = ''
      # set bindings to use Ctrl-o to avoid conflicts with emacs binds
      unbind-key C-b
      unbind-key C-a
      set-option -g prefix C-o
      bind-key C-o send-prefix
      bind-key C-o last-window

      # increase the scrollback limit
      set -g history-limit 10000

      set -g repeat-time 125
      set -g base-index 1
    '';
    mouse = true;
    # tmuxp.enable = true # TODO: research this
    plugins = with pkgs; [
      tmuxPlugins.extrakto # copy data from current buffer with fuzzy search
      tmuxPlugins.sensible
      tmuxPlugins.resurrect # save sesssion
      tmuxPlugins.continuum # autosave resurrect
      tmuxPlugins.cpu
      {
        plugin = inputs.minimal-tmux.packages.${pkgs.system}.default;
        extraConfig = ''
          set -g @minimal-tmux-fg "#000000"
          set -g @minimal-tmux-bg "#ffffff"
          set -g @minimal-tmux-indicator-str " C-o "
          set -g @minimal-tmux-justify "left"  # centre
          set -g @minimal-tmux-status "top"
          set -g @minimal-tmux-show-expanded-icons-for-all-tabs true

          set -g @minimal-tmux-status-right-extra ""
          set -g @minimal-tmux-status-left-extra ""
          set -g @minimal-tmux-status-right "tmux: #{session_name}"

          set -g @minimal-tmux-use-arrow true
          set -g @minimal-tmux-left-arrow ""
          set -g @minimal-tmux-right-arrow ""
        '';
      }

      # tmux-fzf: https://github.com/sainnhe/tmux-fzf
      {
        plugin = tmuxPlugins.tmux-fzf;
        extraConfig = ''
          TMUX_FZF_LAUNCH_KEY="C-f"
        '';
      }
    ];
    sensibleOnTop = true;
  };
}
