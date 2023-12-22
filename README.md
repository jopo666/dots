# Dotfiles

Prepare everyting on Ubuntu.

```sh
sudo update && sudo upgrade
sudo chsh jopo -s zsh
sh <(curl -L https://nixos.org/nix/install) --daemon
```

Bootstrap dotfiles.

```sh
bash install.sh
```

Next enable following settings in Firefox and copy `chrome` folder to the firefox profile.

```
toolkit.legacyUserProfileCustomizations.stylesheets true
ui.key.menuAccessKeyFocuses false
```

And then generate your SSH keys and change at least the origin of this repo.

```bash
ssh-keygen -t ed25519 -C "email@here.com" -f .ssh/github
# After adding the ssh key to github.
git remote set-url origin git@github.com:jopo666/dots.git
```

