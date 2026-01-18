{ config, pkgs, ... }:

{
  # TODO: what is it. How to move anywhere?!
  home.stateVersion = "25.11";
  # make .config for all configs.
  xdg.enable = true;
  programs.bash = {
    enable = true;
    shellAliases = {
      gst = "git status";
      btw = "echo WORKS";
    };
  };

  imports = [
    ./common.nix
    ./programs/git.nix
    ./programs/sound.nix
    ./programs/bash.nix
    ./programs/brave.nix # to search web
    ./programs/internet.nix
    ./programs/message.nix
    ./programs/terminal.nix
    ./programs/ai.nix
    ./programs/formatters.nix
  ];
}
