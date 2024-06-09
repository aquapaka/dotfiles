#!/bin/bash

#  Rice script
#  Author  :  aquapaka
#  Url     :  https://github.com/aquapaka/dotfiles
#  About   :  This file will configure and launch the rice.
#

avaiableThemes=("meimei" "tlinh" "mtram" "khanhoa" "arcade")

usage() {
  printf "
Rice Script for apply a rice theme

Usage:
`basename $0`\t[meimei] \t Warming and caring
\t[tlinh] \t Only in my dreams
\t[mtram]  \t Calming and peaceful
\t[khanhoa] \t She can plays guitar
\t[arcade] \t WARNING! Only For Truest Gamer!! May hurt your eyes!!!
"
}

# Set wezterm theme
set_wezterm_theme() {
  echo "Setting wezterm theme..."
  cat ./rices/$theme/wezterm/wezterm-theme.lua > ~/.config/wezterm/wezterm-theme.lua
}

# Set glazewm configs
set_glazewm_config() {
  echo "Setting Glazewm config..."
  MERGED_CONFIG=$(yq eval-all '. as $item ireduce ({}; . * $item )' ~/.glaze-wm/config.yaml ./rices/$theme/glaze-theme-config.yaml)
  printf '%s\n' "$MERGED_CONFIG" > ~/.glaze-wm/config.yaml
  glazewm command '"reload config"' >/dev/null
}

# Set desktop wallpaper
set_desktop_wallpaper() {
  powershell ./wackground.ps1 ./rices/$theme/wallpapers --set-random
}

# Set VSCode theme
set_vscode_theme() {
  echo "Setting vscode theme..."
  echo "$(jq -s '.[0] * .[1]' ~/AppData/Roaming/Code/User/settings.json ./rices/$theme/vscode-theme-settings.json)" > ~/AppData/Roaming/Code/User/settings.json
}

# Goes to this script location first
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

for theme in "${avaiableThemes[@]}"; do
  if [[ "$1" == "$theme" ]]; then
    echo "Applying $theme theme..."

    # # Apply configs
    set_glazewm_config
    set_desktop_wallpaper
    set_wezterm_theme
    set_vscode_theme

    echo "Completed!"
    exit 1
  fi
done

usage
