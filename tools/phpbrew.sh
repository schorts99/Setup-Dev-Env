setup_phpbrew() {
  if command -v phpbrew >/dev/null 2>&1; then
    echo "✅ PHPBrew is already installed"
    return 0
  fi

  echo "Starting PHPBrew installation..."

  brew install phpbrew
  phpbrew init

  local path_line='[[ -e ~/.phpbrew/bashrc ]] && source ~/.phpbrew/bashrc'
  local conf_file="$HOME/.bashrc"

  if [[ "$SHELL" == *"zsh"* ]]; then
    conf_file="$HOME/.zshrc"
  fi

  if ! grep -Fq "$path_line" "$conf_file"; then
    echo "" >> "$conf_file"
    echo "$path_line" >> "$conf_file"
  fi

  echo "✅ PHPBrew installed"
}
