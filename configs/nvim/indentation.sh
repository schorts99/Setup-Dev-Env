config_indentation() {
  echo "Configuring indentation to use tabs and width of 2"

  local conf="$HOME/.config/nvim/init.lua"
  local header_added=false

  mkdir -p "$(dirname "$conf")"
  touch "$conf"

  while IFS=":" read -r key value; do
    pattern="vim.opt.$key"
    new_line="vim.opt.$key = $value"

    if grep -q "^$pattern[[:space:]]*=" "$conf"; then
      perl -i.bak -pe "s|^\Q$pattern\E\s*=.*|$new_line|" "$conf"
      rm -f "$conf.bak"
      echo "  ✅ Updated $key"
    else
      if [ "$header_added" = false ]; then
        printf "\n-- Indentation\n" >> "$conf"
        header_added=true
      fi

      echo "$new_line" >> "$conf"
      echo "  ➕ Added $key"
    fi
  done <<EOF
expandtab:false
tabstop:2
shiftwidth:2
softtabstop:2
EOF

  echo "🎉 Indentation configured"
}
