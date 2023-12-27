# Dotfiles

Prepare everyting on Ubuntu.

```bash
sudo apt update && sudo apt update
# Change shell to zsh.
sudo chsh jopo -s zsh
# Download homebrew and it's dependencies
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
sudo apt-get install build-essential
```

Bootstrap dotfiles.

```bash
bash install.sh
```

Install tmux plugin manager.

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Generate your SSH keys.

```bash
ssh-keygen -t ed25519 -C "email@here.com" -f .ssh/github
```

Enable following settings in Firefox and copy `chrome` folder to the firefox profile.

```
browser.tabs.closeWindowWithLastTab
toolkit.legacyUserProfileCustomizations.stylesheets true
ui.key.menuAccessKeyFocuses false
```

