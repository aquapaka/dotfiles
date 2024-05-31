#!/bin/bash

#  Rice script
#  Author  :  aquapaka
#  Url     :  https://github.com/aquapaka/dotfiles
#  About   :  This file will configure and launch the rice.
#

avaiableThemes=("meimei" "tlinh")

usage() {
  printf "
Rice Script for Apply a rice theme

Usage:
`basename $0`\t[meimei] \t Nicest girl
\t[tlinh] \t Who is this?
"
}

# Set alacritty colorscheme
set_alacritty_config() {
  cat ./rices/$theme/alacritty/rice-colors.toml > ~/AppData/Roaming/alacritty/rice-colors.toml
  cat ./rices/$theme/alacritty/fonts.toml > ~/AppData/Roaming/alacritty/fonts.toml
}

# Set glazewm configs
set_glazewm_config() {
  MERGED_CONFIG=$(yq eval-all '. as $item ireduce ({}; . * $item )' ~/.glaze-wm/config.yaml ./rices/$theme/glaze-theme-config.yaml)

  printf '%s\n' "$MERGED_CONFIG" > ~/.glaze-wm/config.yaml

  glazewm command '"reload config"' >/dev/null
}

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"

for theme in "${avaiableThemes[@]}"; do
  if [[ "$1" == "$theme" ]]; then
    echo "Applying $theme theme"

    # # Apply configs
    set_alacritty_config
    set_glazewm_config

    echo "Done!"
    exit 1
  fi
done

usage
