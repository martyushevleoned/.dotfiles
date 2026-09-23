# custom utils
[ -n "$(which make)" ] && make -C $HOME/.utils > /dev/null && PATH=$PATH:$HOME/.utils/bin
[ -n "$(which bash)" ] && PATH=$PATH:$HOME/.utils/shell

# nix
[ -n "$(which nix-shell)" ] && {
    [ -z "$(which hx)" ] && hx() { nix-shell -p helix --run "hx $@"; }
    [ -z "$(which nvim)" ] && nvim() { nix-shell -p neovim --run "nvim $@"; }
    [ -z "$(which opencode)" ] && opencode() { nix-shell -p opencode --run "opencode $@"; }
}
