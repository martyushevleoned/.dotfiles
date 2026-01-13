# Dotfiles
## Install

[Docker](https://docs.docker.com/engine/install/)
```shell
sudo groupadd docker && sudo usermod -aG docker $USER
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```

[Nix](https://nixos.org/download/https://nixos.org/download/)
```shell
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon
```
