{
  config,
  pkgs,
  lib,
  ...
}: {
  specialisation.gnome = {
    inheritParentConfig = true;
  };
}