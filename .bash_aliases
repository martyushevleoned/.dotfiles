#utils
alias utils='~/.utils.sh'
[ -f ~/.study.sh ] && alias study='~/.study.sh'
[ -f ~/.work.sh ] && alias work='~/.work.sh'

# nix
[ -n "$(which nix-shell)" ] && {
    alias dev-shell='nix-shell ~/.config/nix/dev.nix --run $SHELL'
    alias python-shell='nix-shell ~/.config/nix/python.nix --run $SHELL'
    [ -z "$(which nvim)" ] && nvim() { nix-shell -p neovim --run "nvim $@"; }
    [ -z "$(which vim)" ] && vim() { nix-shell -p vim --run "vim $@"; }
}
