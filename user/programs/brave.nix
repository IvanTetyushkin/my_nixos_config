{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.userSettings.browser;
in
{
  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        brave
      ];
    };
  };

}
