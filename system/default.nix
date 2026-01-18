{ config, ... }:

{
  imports = [
    ./configuration.nix
    ./users_setup.nix
  ];
}
