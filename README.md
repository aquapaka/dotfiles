# 🍙 My Ricing Dotfiles for Windows 11

Yes it's **Windows**

## Introduction

### ❤️ For the Ricing and Unixporn Enthusiasts

Are you **a ricing nerd** or **a unixporn enthusiast** who has to use Windows but still misses the customizability of Linux? Look no further! This repository is a treasure trove of my ricing dotfiles tailored specifically for Windows.

### ⚙️ Custom Themes and Configurations

It includes a variety of custom themes, scripts, and configurations designed to bring the same level of aesthetic appeal and functionality to your Windows desktop that you love from your Linux setups.

### ⚡ Instant Theme Switching

Easily switch themes on the fly with just one press. Keep your desktop fresh and aligned with your mood or preferences instantly and effortlessly.

### 😍 Transform Your Windows Experience

Dive in, tweak to your heart's content, and transform your Windows environment into a beautifully riced masterpiece!

## Core

- Terminal: **Alacritty**
- Shell: **Zsh** inside MSYS2
- Tiling Window Manager: **Komorebi**
- Bar: **Zebar**
- Package manager: **Winget**
- Dotfiles manager: **Chezmoi**

## 🎨 Themes

| ❤️ meimei |
| :---: |
| Warming and caring |
|![meimei-1](rice-previews/meimei-1.png)|
|![meimei-2](rice-previews/meimei-2.png)|
|![meimei-3](rice-previews/meimei-3.png)|

| ❤️ tlinh |
| :---: |
| Only in my dreams |
|![tlinh-1](rice-previews/tlinh-1.png)|
|![tlinh-2](rice-previews/tlinh-2.png)|
|![tlinh-3](rice-previews/tlinh-3.png)|

| ❤️ mtram |
| :---: |
| Calming and peaceful |
|![mtram-1](rice-previews/mtram-1.png)|
|![mtram-2](rice-previews/mtram-2.png)|
|![mtram-3](rice-previews/mtram-3.png)|

| ❤️ arcade |
| :---: |
| ⚠️ WARNING! Only For Truest Gamer!! May hurt your eyes!!! |
|![arcade-1](rice-previews/arcade-1.png)|
|![arcade-2](rice-previews/arcade-2.png)|
|![arcade-3](rice-previews/arcade-3.png)|

| ❤️ khanhoa |
| :---: |
| She plays guitar |
|![khanhoa-1](rice-previews/khanhoa-1.png)|
|![khanhoa-2](rice-previews/khanhoa-2.png)|
|![khanhoa-3](rice-previews/khanhoa-3.png)|

## ⚙️ Current Configurable Settings

You can customize each theme inside ~/.rice-manager/rices and re-apply it (see **Change theme** below)

- ☑️ Wezterm theme
- ☑️ GlazeWM theme
- ☑️ Desktop wallpaper based on rice
- ☑️ Vscode theme
- ☑️ Enable/Disable Rounded Cornors (⚠️haven't work on startup yet)
- ☑️ Windows light/dark mode based on rice
- ❓ Discord theme
- 🚧 Btop theme
- 🚧 *under construction*

## 📑 Basic usage

### Change theme

- From alacritty terminal use command: ```rice <theme-name>``` (example: ```rice meimei```)
- Background is selected randomize from rice's wallpaper folder

### Useful keybindings

| Keys | Action |
|:-|:-|
|<kbd>alt</kbd> + <kbd>enter</kbd>| Open terminal|
|<kbd>alt</kbd> + <kbd>Space</kbd>| Open powertoy run |
|<kbd>alt</kbd> + <kbd>h\|j\|k\|l</kbd>| Focus window left \| top \| bottom \| right|
|<kbd>alt</kbd> + <kbd>shift</kbd> + <kbd>h\|j\|k\|l</kbd>| Move focusing window left \| top \| bottom \| right|
|<kbd>alt</kbd> + <kbd>w</kbd>| Close focusing window|
|<kbd>alt</kbd> + <kbd>1\|2\|3\|4\|5\|6\|7\|8\|9\|0</kbd>| Focus workspace {n}|
|<kbd>alt</kbd> + <kbd>shift</kbd> + <kbd>1\|2\|3\|4\|5\|6\|7\|8\|9\|0</kbd>| Move focusing window to workspace {n}|
|<kbd>alt</kbd> + <kbd>m</kbd>| Maximize/Unmaximize current window|
|<kbd>alt</kbd> + <kbd>d</kbd>| Change direction where the next window open should be placed|
|<kbd>alt</kbd> + <kbd>f</kbd>| Make focusing window float/tiled|
|<kbd>ctrl</kbd> + <kbd>alt</kbd> + <kbd>shift</kbd> + <kbd>w</kbd>| Exit glazewm |

Above is customized version of i3 keybindings due to some conflict with Powertoys. You can alway change them in your glaze config file.

## 📦 Step by Step Installation

### Pre-install notices

- If you have just fresh install windows 11, you need to go to Microsoft Store and update your "App Installer". Otherwise winget will not working.

### Install Fonts

Font need to be download and install manually *(Windows is planning to allows installing fonts from winget. Stay tune!)*:

- [Pixelcraft Nerd Font](https://github.com/aquapaka/Pixelcraft/releases) (please download and use Nerd Font version)
- [CaskaydiaCove Nerd Font Mono](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/CascadiaMono.zip)
- [Monaspace](https://github.com/githubnext/monaspace)
- [Scientifica](https://github.com/nerdypepper/scientifica/releases)

### Install chezmoi and apply dotfiles

- Install chezmoi from Winget with: ```winget install chezmoi```
- Initialize chezmoi and apply the dotfiles with: ```chezmoi init --apply aquapaka```

### Install packages

- After chezmoi apply the dotfiles, the chezmoi source folder could be found in ```%userprofile%/.local/share/chezmoi```, **install-packages.ps1** file can be found inside **scripts** folder
- Edit **install-packages.ps1**, comment out packages/apps that are not needed
- Run **install-packages.ps1** script with Powershell to install nessesary packages (⚠️ Note: sometime installation could fail, keep re-run the script until all packages has been installed)

----------------------------

 *🚩 Continue below after MSYS2 has been installed through install-packages.ps1*

### Change MSYS2 home directory

Edit /c/msys64/etc/nsswitch.conf

```
db_home: windows
```

This will set windows user folder as default home directory

### Install Zsh

Open **Powershell** and run those commands to install Zsh theme and plugins

```
# Install Theme: Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.config/zsh/themes/powerlevel10k

# Install Syntax Highlighting Plugin
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.config/zsh/plugins/zsh-syntax-highlighting

# Install Autosuggestions Plugin
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.config/zsh/plugins/zsh-autosuggestions

# Install History Substring Search Plugin
git clone https://github.com/zsh-users/zsh-history-substring-search ~/.config/zsh/plugins/zsh-history-substring-search
```

Open **MSYS2 UCRT64** and run below command to install zsh

```
# Open MSYS2 Ucrt64 and install ZSH
pacman -S zsh
```

### Add New Environment Variables

Add those to Path variables

- "C:\Users\%yourusername%\\.local\bin"
- "C:\Program Files\Win11 Toggle Rounded Corners" (if use with win11-toggle-rounded-corners - see **Optional** below)

### Install VS Code Theme

- Icons:
  - [Gruvbox Material Icons](https://marketplace.visualstudio.com/items?itemName=navernoedenis.gruvbox-material-icons)
- Themes:
  - [Gruvbox](https://marketplace.visualstudio.com/items?itemName=jdinhlife.gruvbox)
  - [Monokai Pro](https://marketplace.visualstudio.com/items?itemName=monokai.theme-monokai-pro-vscode)
  - [Matchalk](https://marketplace.visualstudio.com/items?itemName=lucafalasco.matchalk)
  - [Neon City](https://marketplace.visualstudio.com/items?itemName=lakshits11.neon-city)
  - [Paper](https://marketplace.visualstudio.com/items?itemName=a5hk.paper)

- To change vscode UI Font, use this extension: [Fonted](https://marketplace.visualstudio.com/items?itemName=degreat.fonted)

### Restore old context menu (Require restart)

- Open/Run **scripts/Restore-old-context-menu.reg**

### Auto start Komorebi at windows start

Updating...

<!-- ### Auto start GlazeWM at windows start

- Open **Task scheduler**
- Choose **Create Basic Task...**
- Enter any name for GlazeWM task (example: "GlazeWM") then press **Next**
- Trigger: choose *When I log on* then press **Next**
- Program/script: paste in ```C:\Users\%username%\AppData\Local\Microsoft\WinGet\Links\glazewm.exe``` (replace %username% by your username - your user's folder name) then click **Next**
- Tick *Open the Properties dialog for this task when I click Finish* then click **Finish**

- Inside Properties window, set the following settings for each tab:
  - **General**: enable *Run with highest privileges* (required for glazeWM could manages all windows)
  - **Conditions**: disable/untick *everything* (including greyed out settings)
  - **Settings**: disable/untick *Stop the task if it runs longer than:*
- Click **Ok** to save everything and we're good to go -->

### Optional

- Allow enable/disable rounded corners between themes
  - Install windows 11 rounded corners setup: [win11-toggle-rounded-corners](https://github.com/oberrich/win11-toggle-rounded-corners)
- Enable automatically hide the taskbar

### Other

- Dotfiles inspired by gh0stzk dotfiles: <https://github.com/gh0stzk/dotfiles>
- Food script by Xero: <https://github.com/xero/dotfiles>
