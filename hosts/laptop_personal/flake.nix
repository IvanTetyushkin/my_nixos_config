{
  description = "NixOS setup";

  outputs =
    inputs@{ self, ... }:
    let
      # TODO: how to move this to host hardware info?!
      system = "x86_64-linux";

      #magic 01
      host = builtins.baseNameOf ./.;
      # magic 02. setup packages.
      nixpkgs-patched = (import inputs.nixpkgs { inherit system; }).applyPatches {
        name = "nixpkgs-patched";
        src = inputs.nixpkgs;
        patches = [ ];
      };
      pkgs = import nixpkgs-patched {
        inherit system;
        overlays = [
          inputs.emacs-overlay.overlays.default
        ];
      };
      unstable-pkgs = import inputs.nixpkgs-unstable {
        inherit system;
      };
      lib = inputs.nixpkgs.lib;
      hw_config_path = inputs.hw_config_path;
    in
    {
      nixosConfigurations.nixos = lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit hw_config_path; };
        modules = [
          # host specific configuration
          { config.networking.hostName = host; }
          ./default.nix
          ../../system
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager.extraSpecialArgs = {
              inherit pkgs;
              inherit unstable-pkgs;
              inherit inputs;
            };
          }
        ];
      };
    };
  inputs = {
    hw_config_path = {
      url = "path:/etc/nixos";
      flake = false;
    };
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nixpkgs.url = "nixpkgs/nixos-25.11";
    # why we need this
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      # not override pkgs from nixpkg
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # emacs setup - emacsWithPackagesFromUsePackage
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
