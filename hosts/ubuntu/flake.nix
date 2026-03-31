{
  description = "Home Manager configuration with flakes";
  # to rebuild, in current directory:
  # nix run home-manager -- switch --flake .#ivant -b backups
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      # not override pkgs from nixpkg
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    # emacs setup - emacsWithPackagesFromUsePackage
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ self, ... }:
    let
      system = "x86_64-linux";
      pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = [
          inputs.emacs-overlay.overlays.default
        ];
      };
      unstable-pkgs = inputs.nixpkgs-unstable.legacyPackages.${system};
      lib = inputs.nixpkgs.lib;
    in
    {
      homeConfigurations.ivant = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit unstable-pkgs;
        };
        modules = [ ./home.nix ];
      };
    };
}
