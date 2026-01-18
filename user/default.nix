{ config, ... }:

{
  imports = [
    ./home.nix
    ./emacs/setup.nix
  ];
}
