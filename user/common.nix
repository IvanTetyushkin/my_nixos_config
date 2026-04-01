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
      browser.enable = lib.mkEnableOption "Enable browser";
      internet.enable = lib.mkEnableOption "Enable additions to internet";
      message.enable = lib.mkEnableOption "Enable messagers";
      ai.enable = lib.mkEnableOption "Enable AI-releated separate stuff";
      terminal.enable = lib.mkEnableOption "Enable additional terminal (kitty)";
    };
  };
}
