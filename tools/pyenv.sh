setup_pyenv() {
  if command -v pyenv >/dev/null 2>&1; then
    echo "✅ PyENV is already installed"

    return 0
  fi

  echo "Starting PyENV installation..."

  brew install pyenv

  local shell_name
  shell_name=$(basename "$SHELL")

  if [[ "$shell_name" == "zsh" ]]; then
    RC_FILE="$HOME/.zshrc"
    PROFILE_FILE="$HOME/.zprofile"
    INIT_CMD="zsh"
  else
    RC_FILE="$HOME/.bashrc"
    PROFILE_FILE="$HOME/.profile"
    INIT_CMD="bash"
  fi

  export PYENV_ROOT="$HOME/.pyenv"
  [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init - $INIT_CMD)"

  {
    echo ''
    echo '# Pyenv configuration'
    echo 'export PYENV_ROOT="$HOME/.pyenv"'
    echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"'
    echo "eval \"\$(pyenv init - $INIT_CMD)\""
  } >> "$RC_FILE"
  {
    echo ''
    echo '# Pyenv configuration'
    echo 'export PYENV_ROOT="$HOME/.pyenv"'
    echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"'
  } >> "$PROFILE_FILE"

  echo "✅ PyENV installed"
}
