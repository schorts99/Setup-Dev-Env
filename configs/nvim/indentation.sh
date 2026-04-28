config_indentation() {
  echo "Configuring indentation to use tabs and width of 2"

  local conf="$HOME/.config/nvim/init.lua"
  local header_added=false

  mkdir -p "$(dirname "$conf")"
  touch "$conf"

  local -A settings=(
    ["expandtab"]="false"
    ["tabstop"]="2"
    ["shiftwidth"]="2"
    ["softtabstop"]="2"
  )

  for key in "${!settings[@]}"; do
    local value="${settings[$key]}"
    local pattern="vim.opt.$key"
    local new_line="vim.opt.$key = $value"

    if grep -q "$pattern =" "$conf"; then
      perl -i -pe "s|\Q$pattern\E\s*=.*|$new_line|" "$conf"
      echo "  ✅ Updated $key"
    else
			if [ "$header_added" = false ]; then
        echo "" >> "$conf"
				echo "-- Indentation" >> "$conf"
        header_added=true
      fi

      echo "$new_line" >> "$conf"
      echo "  ➕ Added $key"
    fi
  done

  echo "🎉 Indentation configured"
}
