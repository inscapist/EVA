inputs:

{
  fontDankMono = pkgs: _: { dank-mono = import ./font-dankmono pkgs; };
  keyd = pkgs: _: { keyd = import ./keyd.nix pkgs; };
  overops = pkgs: _: { overops = import ./overops.nix pkgs; };

  # use emacs 29 for whatever reason
  # emacs29 = (_: prev: {
  #   emacs-pgtk = prev.emacs-pgtk.overrideAttrs (old: {
  #     name = "emacs-pgtk";
  #     version = inputs.emacs29.shortRev;
  #     src = inputs.emacs29;
  #     withPgtk = true;
  #     withGTK3 = true;
  #   });
  # });

  # # no need to add in in Doom
  # polyglot = (
  #   _: prev:
  #   let
  #     grammers = with prev.tree-sitter-grammars; [
  #       tree-sitter-bash
  #       tree-sitter-cmake
  #       tree-sitter-clojure
  #       tree-sitter-clojurescript
  #       tree-sitter-cpp
  #       tree-sitter-css
  #       tree-sitter-dockerfile
  #       tree-sitter-elm
  #       tree-sitter-elisp
  #       tree-sitter-elixir
  #       tree-sitter-go
  #       tree-sitter-gomod
  #       tree-sitter-haskell
  #       tree-sitter-javascript
  #       tree-sitter-json
  #       tree-sitter-markdown
  #       tree-sitter-nix
  #       tree-sitter-python
  #       tree-sitter-ruby
  #       tree-sitter-rust
  #       tree-sitter-scss
  #       tree-sitter-sql
  #       tree-sitter-toml
  #       tree-sitter-tsx
  #       tree-sitter-typescript
  #       tree-sitter-vim
  #       tree-sitter-yaml
  #     ];
  #   in
  #   {
  #     emacs-pgtk = prev.emacs-pgtk.overrideAttrs (old: {
  #       name = "emacs-pgtk";
  #       treeSitterPlugins = grammers;
  #     });
  #   }
  # );
}
