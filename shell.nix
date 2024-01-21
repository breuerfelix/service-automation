{ pkgs ? import <nixpkgs> {} }:
  pkgs.mkShell {
    buildInputs = with pkgs; [
      go_1_19
      # go
    ];

    shellHook = ''
      export FOO="some important build arg"
    '';
}
