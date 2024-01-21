{ pkgs ? import <nixpkgs> {} }:
  pkgs.mkShell {
    buildInputs = with pkgs; [
      # go # uses latest
      go_1_19
      slides # presentation tool
    ];

    shellHook = ''
      export FOO="some important build arg"
    '';
}
