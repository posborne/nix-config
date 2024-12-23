{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
let
  desktopCfg = config.features.desktop;
  gnomeCfg = config.features.desktop.gnome;
in
{
  config = mkIf (desktopCfg.enable && gnomeCfg.enable) {
    # make available icon/gtk themes
    gtk = {
      enable = true;

      gtk3.extraConfig = {
        Settings = ''
          gtk-application-prefer-dark-theme=1
        '';
      };

      gtk4.extraConfig = {
        Settings = ''
          gtk-application-prefer-dark-theme=1
        '';
      };
    };

    # set the theme
    home.sessionVariables.GTK_THEME = "palenlight";

    # various configuration of the desktop with dconf
    #
    # you can use `dconf watch /` to see what changes when
    # you tweak settings to get ideas.
    dconf.settings = with lib.hm.gvariant; {
      "org/gnome/shell" = {
        # pinned apps
        favorite-apps = [
          "firefox.desktop"
          "code.desktop"
          "org.gnome.Console.desktop"
          "org.gnome.Nautilus.desktop"
          "emacs.desktop"
        ];
      };

      # workspaces
      "org/gnome/desktop/wm/preferences" = {
        num-workspaces = 4;
        workspace-names = [
          "1"
          "2"
          "3"
          "4"
        ];

        # include min/max/close buttons on right side
        button-layout = "appmenu:minimize,maximize,close";
      };

      # disable mouse acceleration
      "org/gnome/desktop/peripherals/mouse" = {
        accel-profile = "flat";
      };

      "org/gnome/desktop/session" = {
        idle-delay = mkUint32 600; # blank screen @ 10 minutes
      };

      "org/gnome/desktop/screensaver" = {
        lock-delay = mkUint32 1800; # 30 minutes
        lock-enabled = true;
      };

      # extensions
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = [
          "user-theme@gnome-shell-extensions.gcampax.github.com"
          "dash-to-panel@jderose9.github.com"
          "Vitals@CoreCoding.com"
          "space-bar@luchrioh"
          "tilingshell@ferrarodomenico.com"
          "native-window-placement@gnome-shell-extensions.gcampax.github.com"
        ];
      };

      # dash to panel settings
      "org/gnome/shell/extensions/dash-to-panel" = {
        appicon-margin = 8;
        appicon-padding = 4;
        available-monitors = [ 0 ];
        dot-position = "BOTTOM";
        hotkeys-overlay-combo = "TEMPORARILY";
        leftbox-padding = -1;
        panel-anchors = ''
          {"0":"MIDDLE"}
        '';
        panel-lengths = ''
          {"0":100}
        '';
        panel-positions = ''
          {"0":"TOP"}
        '';
        panel-sizes = ''
          {"0":32}
        '';
        primary-monitor = 0;
        status-icon-padding = -1;
        tray-padding = -1;
        window-preview-title-position = "TOP";
      };

      # vitals extension
      "org/gnome/shell/extensions/vitals" = {
        hot-sensors = [
          "_memory_usage_"
          "_processor_usage_"
          "_storage_free_"
        ];
        show-network = true;
      };

      "org/gnome/desktop/interface" = {
        accent-color = "blue";
        color-scheme = "prefer-dark";
        enable-hot-corners = false;
        gtk-theme = "Adwaita";
        icon-theme = "Adwaita";
        toolkit-accessibility = false;
        monospace-font-name = "CaskaydiaCove Nerd Font 14";
      };

      "org/gnome/Console" = {
        use-system-font = false;
        custom-font = "CaskaydiaCove Nerd Font 12";
        ignore-scrollback-limit = true;
      };

      "org/gnome/desktop/input-sources" = {
        xkb-options = [
          "terminate:ctrl_alt_bksp" # ctrl+alt+bksp exits X session
          "ctrl:nocaps" # caps acts as ctrl
          "shift:both_capslock" # hit both shifts together to get capslock
        ];
      };

      "org/gnome/shell/extensions/tilingshell" = {
        # could bump this up for a different aesthetic, but why waste pixels
        outer-gaps = mkUint32 8;
        inner-gaps = mkUint32 8;
      };

    };

    # install required packages for themes, gnome-extensions, etc.
    home.packages = with pkgs; [
      dconf2nix
      catppuccin-gtk
      catppuccin-cursors
      catppuccin-papirus-folders
      palenight-theme
      gnome-tweaks
      gnomeExtensions.user-themes
      gnomeExtensions.tray-icons-reloaded
      gnomeExtensions.vitals
      gnomeExtensions.dash-to-panel
      gnomeExtensions.space-bar
      gnomeExtensions.tiling-shell
    ];
  };

}
