{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
    buildInputs = with pkgs; [
        python3
        python3Packages.ipykernel
        python3Packages.jupyterlab
        python3Packages.matplotlib
        python3Packages.numpy
        python3Packages.pandas
        python3Packages.scipy
        stdenv.cc.cc.lib
    ];
}

