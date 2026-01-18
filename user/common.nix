{ lib, ... }:
{
  options = {
    userSettings = {
      name = lib.mkOption {
        default = "NO NAME";
        description = "User full name. Used for git mainly.";
        type = lib.types.str;
      };
      email = lib.mkOption {
        default = "NO EMAIL";
        description = "User email. Used for git mainly.";
        type = lib.types.str;
      };
    };
  };
}
