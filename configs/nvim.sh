DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$DIR/nvim/indentation.sh"

config_nvim() {
  if ! command -v nvim >/dev/null 2>&1; then
    echo "❌ NeoVim is not installed"
    
    return 1
  fi

  echo "Starting NeoVim configuration..."
  config_indentation
  echo "✅ NeoVim configured"
}
