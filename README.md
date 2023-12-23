# Dotfiles

Prepare everyting on Ubuntu.

```bash
# Change shell to zsh.
sudo apt update && sudo apt update
sudo chsh jopo -s zsh

# Download homebrew and it's dependencies
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
sudo apt-get install build-essential
brew install gcc
```

Bootstrap dotfiles.

```bash
bash install.sh
```

Next enable following settings in Firefox and copy `chrome` folder to the firefox profile.

```
browser.tabs.closeWindowWithLastTab
toolkit.legacyUserProfileCustomizations.stylesheets true
ui.key.menuAccessKeyFocuses false
```

And then generate your SSH keys and change at least the origin of this repo.

```bash
ssh-keygen -t ed25519 -C "email@here.com" -f .ssh/github
# After adding the ssh key to github.
git remote set-url origin git@github.com:jopo666/dots.git
```
