#!/bin/bash
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

cp -rs --remove-destination $SCRIPTPATH/../.config/sxhkd ~/.config
cp -rs --remove-destination $SCRIPTPATH/../.config/bspwm ~/.config
cp -rs --remove-destination $SCRIPTPATH/../.config/alacritty ~/.config
cp -rs --remove-destination $SCRIPTPATH/../.config/zsh ~/.config
cp -rs --remove-destination $SCRIPTPATH/../.config/gtk-3.0 ~/.config
cp -rs --remove-destination $SCRIPTPATH/../.config/environment.d ~/.config
cp -rs --remove-destination $SCRIPTPATH/../.config/chrome-flags.conf ~/.config
ln -fs $SCRIPTPATH/../home/.zshrc ~/.zshrc
ln -fs $SCRIPTPATH/../home/.zprofile ~/.zprofile
ln -fs $SCRIPTPATH/../home/.xinitrc ~/.xinitrc
ln -fs $SCRIPTPATH/../home/.fehbg ~/.fehbg
cp -rs --remove-destination $SCRIPTPATH/../.local/bin ~/.local
#cp -rs --remove-destination $SCRIPTPATH/../.local/share/asciiart ~/.local/share
