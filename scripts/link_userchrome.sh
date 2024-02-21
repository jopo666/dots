#!/usr/bin/env bash

FIREFOX_PROFILE=$(find ~/snap/firefox/common/.mozilla/firefox/ -maxdepth 1 -type d | grep default$)
if [ -n "$FIREFOX_PROFILE" ]; then
	ln -sfv "$PWD/mozilla/chrome" "$FIREFOX_PROFILE/chrome"
else
    echo "ERROR: Could not find Firefox profile"
    exit 1
fi
