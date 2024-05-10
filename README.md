# Dotfiles

My dotfiles for Windows 11

- Terminal: **Alacritty**
- Shell: **Zsh** inside MSYS2
- WM/Bar: **GlazeWM**
- Package manager: **Winget**
- Dotfiles management: **Chezmoi**

## Themes

### ❤️ Meimei Gruvbox

<img src="screenshots/screenshot-gruvbox-3.png" alt="theme screenshot 1" />
<img src="screenshots/screenshot-gruvbox-2.png" alt="theme screenshot 2" />


## Installation

### Install Font

Font need to be download and install:

- [Pixelcraft](https://github.com/aquapaka/Pixelcraft/releases): For terminal, code editor's font and status bar text
- [Scientifica](https://github.com/nerdypepper/scientifica/releases): For some apps UI font (Vscode, IntelliJ, etc.)

### Install chezmoi and apply dotfiles

- Install chezmoi from Winget with: ```winget install chezmoi```
- Initialize chezmoi and apply the dotfiles with: ```chezmoi init --apply aquapaka```

### Install packages

- After chezmoi apply the dotfiles, the chezmoi source folder could be found in ```%userprofile%/.local/share/chezmoi```, **install-packages.ps1** file can be found inside **scripts** folder
- Edit **install-packages.ps1**, comment out packages that are not needed
- Run **install-packages.ps1** script with Powershell

### Change MSYS2 home directory

Edit /c/msys64/etc/nsswitch.conf

```
db_home: windows
```

This will set windows user folder as default home directory

### Install Zsh

```
# Open MSYS2 Ucrt64 and install ZSH
pacman -S zsh

# Install Theme: Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.config/zsh/themes/powerlevel10k

# Install Syntax Highlighting Plugin
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.config/zsh/plugins/zsh-syntax-highlighting

# Install Autosuggestions Plugin
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.config/zsh/plugins/zsh-autosuggestions

# Install History Substring Search Plugin
git clone https://github.com/zsh-users/zsh-history-substring-search ~/.config/zsh/plugins/zsh-history-substring-search
```

### Add New Environment Variables

Add "C:\Users\aquapaka\.local\bin" to Path variables

### IntelliJ Theme

- Theme: [Gruvbox Theme](https://plugins.jetbrains.com/plugin/20558-gruvbox--theme)
- Change UI and Editor Font: From IntelliJ Settings

### VS Code Theme

- Icons: [Gruvbox Material Icons](https://marketplace.visualstudio.com/items?itemName=navernoedenis.gruvbox-material-icons)
- Theme: [Gruvbox](https://marketplace.visualstudio.com/items?itemName=jdinhlife.gruvbox)
- Change UI Font: [Fonted](https://marketplace.visualstudio.com/items?itemName=degreat.fonted)

### Restore old context menu (Require restart)

- Open/Run **script/Restore-old-context-menu.reg**

### Optional

- Enable automatically hide the taskbar

### Other

- Food script by Xero: <https://github.com/xero/dotfiles>
