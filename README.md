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

