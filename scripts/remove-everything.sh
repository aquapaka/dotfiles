#!/bin/bash

echo "Start remove all but essential packages";
sudo pacman -D --asdeps $(pacman -Qqe);
sudo pacman -D --asexplicit base linux linux-firmware sudo vim networkmanager;
sudo pacman -Qtdq | sudo pacman -Rns -

