{ lib, ...}:
let
  meSubmodule = lib.types.submodule {
    options = {
      name = lib.mkOption {
        type = lib.types.str;
      };
      username = lib.mkOption {
        type = lib.types.str;
      };
      sshPublicKeys = lib.mkOption {
        type = lib.types.listOf lib.types.str;
      };
    };
  };
in
{
  options = {
    me = lib.mkOption {
      type = meSubmodule;
    };
  };
  config = {
    me = {
      name = "Paul Osborne";
      username = "posborne";
      sshPublicKeys = [
        # TODO: changeme
      ];
    };
  };
}
