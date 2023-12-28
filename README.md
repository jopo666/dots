# Dotfiles

## Prepare everyting on Ubuntu

```bash
# Dependencies
sudo apt update && sudo apt update
sudo apt-get install build-essential git curl vim
# Change shell to zsh.
sudo chsh jopo -s zsh
# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## Bootstrap dotfiles

```bash
bash install.sh
```

### After install

```bash
# Generate your SSH keys
ssh-keygen -t ed25519 -C "email@here.com" -f .ssh/github
# Set sudo access
sudo chmod +s $(which brightnessctl)
```

### Firefox

Enable following settings in Firefox and copy `chrome` folder to the firefox profile.

```
browser.tabs.closeWindowWithLastTab
toolkit.legacyUserProfileCustomizations.stylesheets true
ui.key.menuAccessKeyFocuses false
```

