setup_pyenv() {
  if command -v pyenv >/dev/null 2>&1; then
    echo "✅ PyENV is already installed"
    
    return 0
  fi

  echo "Starting PyENV installation..."

  brew install pyenv
  echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
  echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
  echo 'eval "$(pyenv init - bash)"' >> ~/.bashrc
  echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.profile
  echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.profile
  echo 'eval "$(pyenv init - bash)"' >> ~/.profile

  echo "✅ PyENV installed"
}
