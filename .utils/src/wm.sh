#!/bin/bash

dwm()
{
    make setup build run -C $HOME/.config/dwm
}

niri()
{
    # sudo usermod -aG video $USER
    # nix --extra-experimental-features 'nix-command flakes' profile install --impure github:guibou/nixGL
    nix-shell -p niri alacritty fuzzel waybar wofi mako grim slurp wl-clipboard brightnessctl pavucontrol --run 'nixGL dbus-run-session niri --session' 2>&1 | tee /tmp/niri.log
}

$@
