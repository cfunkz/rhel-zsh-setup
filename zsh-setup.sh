#!/bin/bash

# Ensure the script runs as a normal user, not root
if [ "$EUID" -eq 0 ]; then
    echo "Please run this script as a normal user, not root."
    exit 1
fi

echo "Installing required packages..."
sudo dnf install -y epel-release curl util-linux-user which zsh

# Change default shell to zsh
echo "Changing default shell to Zsh..."
chsh -s $(which zsh)

# Verify
echo "Your current shell: $SHELL"

# Install Oh My Zsh
echo "Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Set the Jonathan theme
echo "Setting Oh My Zsh theme to Jonathan..."
sed -i 's/^ZSH_THEME="[^"]*"/ZSH_THEME="jonathan"/' ~/.zshrc

echo "Installing zsh-autosuggestions..."
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

# Enable plugins
echo "Enabling plugins..."
sed -i 's/^plugins=(/&git zsh-autosuggestions /' ~/.zshrc

# Apply changes
echo "Applying changes..."
source ~/.zshrc

echo "Zsh and Oh My Zsh setup complete! Please restart your terminal."
