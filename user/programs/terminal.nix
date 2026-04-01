{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.userSettings.terminal;
in
{
  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        kitty
      ];
    };
  };
}
