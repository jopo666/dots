#!/usr/bin/env bash
set -ueo pipefail

if [[ ! -e scripts ]]; then
	echo "ERROR: Are you in project root?"
	exit 1
fi

find "$HOME" -maxdepth 1 -type l -delete
find "$HOME/.ssh" -maxdepth 1 -type l -delete
find "$HOME/.config" -maxdepth 1 -type l -delete

link_file() {
    src="$1"
    dst="$2"
    if [ -e "$dst" ]; then
        echo "File $src exists, do you want to overwrite it? [y/N]"
        read -r response
        if [ "$response" != "y" ]; then
            return
        else
            rm -v "$dst"
            ln -sv "$src" "$dst"
        fi
    else
        ln -sv "$src" "$dst"
    fi
}

for src in "$PWD"/home/*; do
	if [ -f "$src" ]; then
        link_file "$src" "$HOME/.$(basename "$src")"
	else
		for nested in "$src"/*; do
            link_file "$nested" "$HOME/.$(basename "$src")/$(basename "$nested")"
		done
	fi
done

for src in "$PWD"/config/*; do
    link_file "$src" "$HOME/.config/$(basename "$src")"
done
for src in "$PWD"/bin/*; do
    ln -svf "$src" "$HOME/.local/bin/$(basename "$src")"
done

