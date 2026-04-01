{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.userSettings.message;
in
{
  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        telegram-desktop
      ];
    };
  };
}
