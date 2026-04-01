{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.userSettings.internet;
in
{
  config = lib.mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        openvpn
      ];
    };
  };
}
