if command -v kitty >/dev/null 2>&1; then
  echo "✅ Kitty is already installed"

  return 0
fi

echo "Starting Kitty installation..."

curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

mkdir -p "$HOME/.local/bin"
ln -sf "$HOME/.local/kitty.app/bin/kitty" "$HOME/.local/kitty.app/bin/kitten" "$HOME/.local/bin/"
mkdir -p "$HOME/.local/share/applications"
cp "$HOME/.local/kitty.app/share/applications/kitty.desktop" "$HOME/.local/share/applications/"
sed -i "s|Icon=kitty|Icon=$HOME/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" "$HOME/.local/share/applications/kitty.desktop"
sed -i "s|Exec=kitty|Exec=$HOME/.local/kitty.app/bin/kitty|g" "$HOME/.local/share/applications/kitty.desktop"
mkdir -p "$HOME/.config"
echo 'kitty.desktop' > "$HOME/.config/xdg-terminals.list"

if command -v update-desktop-database >/dev/null 2>&1; then
  update-desktop-database "$HOME/.local/share/applications"
fi

echo "✅ Kitty installed"
