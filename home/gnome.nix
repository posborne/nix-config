{ pkgs, lib, inputs, outputs, ... }:
{
  # make available icon/gtk themes
  gtk = {
    enable = true;

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    theme = {
      name = "palenight";
      package = pkgs.palenight-theme;
    };

    cursorTheme = {
      name = "Numix-Cursor";
      package = pkgs.numix-cursor-theme;
    };

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
        "emacsclient.desktop"
        "org.gnome.Nautilus.desktop"
      ];
    };

    # appearance preferences
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      enable-hot-corners = false;
      accent-color = "blue";
    };

    # # workspaces
    "org/gnome/desktop/wm/preferences" = {
      workspace-names = [ "1" "2" "3" "4" ];
      num-workspaces = 4;
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
        "system-monitor@gnome-shell-extensions.gcampax.github.com"
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "dash-to-panel@jderose9.github.com"
      ];
    };

    # dash to panel settings
    "org/gnome/shell/extensions/dash-to-panel" = {
      panel-positions = [
        (mkDictionaryEntry["0" "TOP"])
      ];
    };
  };

  # install required packages for themes, gnome-extensions, etc.
  home.packages = with pkgs; [
    gnomeExtensions.user-themes
    gnomeExtensions.tray-icons-reloaded
    gnomeExtensions.vitals
    gnomeExtensions.dash-to-panel
    gnomeExtensions.space-bar
  ];
}
