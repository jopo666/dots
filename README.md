# Dotfiles

Bootstrapping everything on ubuntu.

```sh
# install nix for package management
sh <(curl -L https://nixos.org/nix/install) --daemon
nix-shell -p nixpkgs#jq
# pull dotfiles
git clone https://github.com/jopo666/dots
cd dots
./install.sh
exit
```
