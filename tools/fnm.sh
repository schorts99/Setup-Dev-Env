setup_fnm() {
  if command -v fnm >/dev/null 2>&1; then
    echo "✅ FNM is already installed"
    
    return 0
  fi

  echo "Starting FNM installation..."
  
  curl -fsSL https://fnm.vercel.app/install | bash
  
  echo "✅ FNM installed"
}

