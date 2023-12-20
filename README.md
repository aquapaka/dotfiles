# Dotfiles

My dotfiles for windows 11

- Terminal: Windows Terminal
- Shell:
  - Zsh inside MSYS2 (Primary)
  - PowerShell (Secondary)
- Prompt: Starship
- WM/Bar: GlazeWM
- Package manager: Winget
- Dotfiles managed using Chezmoi

## Themes

### ❤️ Meimei (Current)

<img src="screenshots/screenshot-gruvbox-0.png" />
<img src="screenshots/screenshot-gruvbox-1.png" />

### 🕹️ Arcade

<img src="screenshots/desktop-arcade-1.png" />
<img src="screenshots/desktop-arcade.png" />

## Install packages

Run **install-packages.ps1** script

## Install Zsh

```
# Install ZSH
pacman -S git zsh

# Install Theme: Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.config/zsh/themes/powerlevel10k

# Syntax Highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.config/zsh/plugins/zsh-syntax-highlighting

# Autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.config/zsh/plugins/zsh-autosuggestions
```

## Others

- Font need to be download and install: <a href="https://www.nerdfonts.com/font-downloads">CaskaydiaCove Nerd Font</a>
- Enable automatically hide the taskbar
