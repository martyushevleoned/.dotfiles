{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
    buildInputs = with pkgs; [
        clang-tools
        cmake
        docker
        git
        neovim
        python3
        ripgrep
        stow
        tmux
    ];
}
