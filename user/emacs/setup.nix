{ pkgs, ... }:
{
  config = {
    home.packages = with pkgs; [
      (pkgs.emacsWithPackagesFromUsePackage {
        config = ./init.el;
        package = pkgs.emacs-pgtk;
        alwaysEnsure = false;
        # nix-env -f '<nixpkgs>' -qaP -A emacsPackages
        extraEmacsPackages =
          epkgs: with epkgs; [
            eat
            doom-themes
            nix-mode
            cmake-mode
            pdf-tools
            saveplace-pdf-view
            org-roam
            org-roam-ui
            gt
            org-noter
            gptel
            magit
            tmr
            treesit-auto
            tree-sitter-langs
            (treesit-grammars.with-grammars (p: [
              #p.tree-sitter-awk
              p.tree-sitter-bash
              p.tree-sitter-c
              p.tree-sitter-cmake
              p.tree-sitter-commonlisp
              p.tree-sitter-cpp
              #p.tree-sitter-diff
              p.tree-sitter-elisp
              #p.tree-sitter-fortran
              #p.tree-sitter-groovy
              p.tree-sitter-java
              p.tree-sitter-json
              p.tree-sitter-latex
              p.tree-sitter-llvm
              #p.tree-sitter-llvm-mir
              p.tree-sitter-make
              p.tree-sitter-markdown
              #p.tree-sitter-meson
              p.tree-sitter-nix
              #p.tree-sitter-org
              p.tree-sitter-perl
              p.tree-sitter-python
              p.tree-sitter-regex
              p.tree-sitter-ruby
              p.tree-sitter-rust
              #p.tree-sitter-tablegen
              #p.tree-sitter-tcl
              p.tree-sitter-toml
              p.tree-sitter-yaml
            ]))
          ];
      })
    ];
    # TODO: should be in sync with emacs install.
    # seems hardcoded.
    home.file.".emacs".source = ./init.el;
  };
}
