{
  config,
  pkgs,
  unstable-pkgs,
  lib,
  ...
}:
let
  cfg = config.userSettings.ai;
in
{
  config = lib.mkIf cfg.enable {
    home = {
      packages = with unstable-pkgs; [
        ollama-vulkan
      ];
    };
  };
}
