set -euo pipefail

echo ":: Creating directories..."
while IFS= read -r line; do
  if [[ -n "$line" && "$line" != \#* ]]; then
    mkdir -pv $(echo "$line" | awk '{print $1}' | sed "s|^~|$HOME|")
  fi
done < "directories.txt"

echo ":: Linking dotfiles..."
while IFS= read -r line; do
  src=$(echo "$line" | awk '{print $1}' | sed "s|^~|$HOME|")
  dst=$(echo "$line" | awk '{print $3}' | sed "s|^~|$HOME|")
  if [ -L "$dst" ]; then
    echo "Existing link ($dst -> $src)."
  elif [ -e "$dst" ]; then
    echo "Existing file ($dst)."
  else
    ln -vs $src $dst
  fi
done < "links.txt"

echo ":: Installing packages..."
while ifs= read -r line; do
    if [[ -n "$line" && "$line" != \#* ]]; then
        package=$(echo "$line" | awk '{print $1}')
        ./bin/pget $package
    fi
done < "packages.txt"
