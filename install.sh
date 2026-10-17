#!/bin/bash

# Dotfiles installation script
# This script creates symbolic links from the dotfiles repo to the appropriate locations

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get the directory where this script is located (the dotfiles repo root)
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Detect OS
OS="unknown"
case "$OSTYPE" in
  darwin*)  OS="mac" ;;
  linux*)   OS="linux" ;;
  *)        echo -e "${RED}Unsupported OS: $OSTYPE${NC}"; exit 1 ;;
esac

echo -e "${BLUE}🚀 Installing dotfiles for $OS...${NC}"
echo -e "${BLUE}Dotfiles directory: $DOTFILES_DIR${NC}"

# Function to create backup
backup_file() {
  local file="$1"
  if [[ -e "$file" && ! -L "$file" ]]; then
    local backup_dir="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"
    mkdir -p "$backup_dir"
    mv "$file" "$backup_dir/"
    echo -e "${YELLOW}  Backed up existing file to: $backup_dir/$(basename "$file")${NC}"
  fi
}

# Function to create symbolic link
create_symlink() {
  local src="$1"
  local dest="$2"
  local desc="$3"
  
  echo -e "${BLUE}Installing $desc...${NC}"
  
  # Create parent directory if it doesn't exist
  mkdir -p "$(dirname "$dest")"
  
  # Backup existing file/directory if it exists and is not a symlink
  backup_file "$dest"
  
  # Remove existing symlink or file
  rm -rf "$dest"
  
  # Create the symlink
  ln -sf "$src" "$dest"
  echo -e "${GREEN}  ✓ $desc installed${NC}"
}

# Function to copy files (for cases where symlinks aren't appropriate)
copy_file() {
  local src="$1"
  local dest="$2"
  local desc="$3"
  
  echo -e "${BLUE}Installing $desc...${NC}"
  
  # Create parent directory if it doesn't exist
  mkdir -p "$(dirname "$dest")"
  
  # Backup existing file
  backup_file "$dest"
  
  # Copy the file
  cp "$src" "$dest"
  echo -e "${GREEN}  ✓ $desc installed${NC}"
}

echo -e "${BLUE}📁 Creating ~/.config directory if it doesn't exist...${NC}"
mkdir -p "$HOME/.config"

# Check if omarchy configuration exists
OMARCHY_EXISTS=false
if [[ -d "$HOME/.local/share/omarchy" ]]; then
  OMARCHY_EXISTS=true
  echo -e "${YELLOW}⚠️  Omarchy configuration detected - skipping ghostty, hyprland, wofi, waybar, and btop${NC}"
fi

# Install configs that go to ~/.config/
echo -e "\n${BLUE}🔧 Installing application configs to ~/.config/...${NC}"

# Ghostty terminal
if [[ "$OMARCHY_EXISTS" == false && -d "$DOTFILES_DIR/ghostty" ]]; then
  create_symlink "$DOTFILES_DIR/ghostty" "$HOME/.config/ghostty" "Ghostty terminal config"
fi

# Hyprland (Linux only)
if [[ "$OMARCHY_EXISTS" == false && "$OS" == "linux" && -d "$DOTFILES_DIR/hypr" ]]; then
  create_symlink "$DOTFILES_DIR/hypr" "$HOME/.config/hypr" "Hyprland window manager config"
fi

# btop system monitor
if [[ "$OMARCHY_EXISTS" == false && -d "$DOTFILES_DIR/btop" ]]; then
  create_symlink "$DOTFILES_DIR/btop" "$HOME/.config/btop" "btop system monitor config"
fi

# Kitty terminal
if [[ -d "$DOTFILES_DIR/kitty" ]]; then
  create_symlink "$DOTFILES_DIR/kitty" "$HOME/.config/kitty" "Kitty terminal config"
fi

# Waybar (Linux only)
if [[ "$OMARCHY_EXISTS" == false && "$OS" == "linux" && -d "$DOTFILES_DIR/waybar" ]]; then
  create_symlink "$DOTFILES_DIR/waybar" "$HOME/.config/waybar" "Waybar config"
fi

# Wofi launcher (Linux only)
if [[ "$OMARCHY_EXISTS" == false && "$OS" == "linux" && -d "$DOTFILES_DIR/wofi" ]]; then
  create_symlink "$DOTFILES_DIR/wofi" "$HOME/.config/wofi" "Wofi launcher config"
fi

# SwayNC notification center (Linux only)
if [[ "$OMARCHY_EXISTS" == false && "$OS" == "linux" && -d "$DOTFILES_DIR/swaync" ]]; then
  create_symlink "$DOTFILES_DIR/swaync" "$HOME/.config/swaync" "SwayNC notification center config"
fi

# Wlogout logout menu (Linux only)
if [[ "$OMARCHY_EXISTS" == false && "$OS" == "linux" && -d "$DOTFILES_DIR/wlogout" ]]; then
  create_symlink "$DOTFILES_DIR/wlogout" "$HOME/.config/wlogout" "Wlogout logout menu config"
fi

# Wallpapers (used by swaybg)
if [[ -d "$DOTFILES_DIR/wallpapers" ]]; then
  create_symlink "$DOTFILES_DIR/wallpapers" "$HOME/wallpapers" "Wallpapers directory (swaybg)"
fi

# Zellij terminal multiplexer
if [[ -d "$DOTFILES_DIR/zellij" ]]; then
  create_symlink "$DOTFILES_DIR/zellij" "$HOME/.config/zellij" "Zellij terminal multiplexer config"
fi

# Zsh configuration
echo -e "\n${BLUE}🐚 Installing Zsh configuration...${NC}"
if [[ -f "$DOTFILES_DIR/zsh/zshrc" ]]; then
  create_symlink "$DOTFILES_DIR/zsh/zshrc" "$HOME/.zshrc" "Zsh configuration"
fi
# Install bin scripts
echo -e "\n${BLUE}🔧 Installing utility scripts...${NC}"
if [[ -d "$DOTFILES_DIR/bin" ]]; then
  mkdir -p "$HOME/.local/bin"
  for script in "$DOTFILES_DIR/bin"/*; do
    if [[ -f "$script" ]]; then
      script_name=$(basename "$script")
      create_symlink "$script" "$HOME/.local/bin/$script_name" "Utility script: $script_name"
      chmod +x "$HOME/.local/bin/$script_name"
    fi
  done
fi

# Platform-specific configurations
if [[ "$OS" == "mac" ]]; then
  echo -e "\n${BLUE}🍎 Installing macOS-specific configurations...${NC}"
  
  # iTerm2 color schemes
  if [[ -d "$DOTFILES_DIR/iterm" ]]; then
    ITERM_CONFIG_DIR="$HOME/Library/Application Support/iTerm2/DynamicProfiles"
    mkdir -p "$ITERM_CONFIG_DIR"
    echo -e "${BLUE}Installing iTerm2 color schemes...${NC}"
    echo -e "${YELLOW}  Note: iTerm2 color schemes copied to DynamicProfiles directory${NC}"
    echo -e "${YELLOW}  You'll need to manually import them in iTerm2 preferences${NC}"
    
    for colorscheme in "$DOTFILES_DIR/iterm"/*.itermcolors; do
      if [[ -f "$colorscheme" ]]; then
        cp "$colorscheme" "$ITERM_CONFIG_DIR/"
        echo -e "${GREEN}  ✓ Copied $(basename "$colorscheme")${NC}"
      fi
    done
  fi
fi

echo -e "\n${GREEN}🎉 Dotfiles installation completed!${NC}"
echo -e "\n${BLUE}📋 Next steps:${NC}"
echo -e "  1. Restart your terminal or run: ${YELLOW}source ~/.zshrc${NC}"
echo -e "  2. If you installed Hyprland configs, restart your session"
echo -e "  3. Configure any application-specific settings as needed"

if [[ -d "$HOME/.dotfiles_backup" ]]; then
  echo -e "\n${YELLOW}📦 Backed up files are stored in: ~/.dotfiles_backup${NC}"
fi

echo -e "\n${GREEN}✨ Happy coding!${NC}"
