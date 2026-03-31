{
  config,
  pkgs,
  lib,
  ...
}:

{
  config = {
    userSettings = {
      name = "Ivan Tetyushkin";
      email = "tetyushkin.ia@outlook.com";
    };
  };
  config.home.username = "ivant";
  config.home.homeDirectory = "/home/ivant";

  # Enable Home Manager
  config.programs.home-manager.enable = true;

  config.home.stateVersion = "25.11"; # Match your nixpkgs version
  imports = [
    ../../user
  ];
}
