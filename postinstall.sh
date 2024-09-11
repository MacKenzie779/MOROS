#!/usr/bin/env bash

#greeting
echo "                 _   _           _        _ _"
echo " _ __   ___  ___| |_(_)_ __  ___| |_ __ _| | |"
echo "| '_ \ / _ \/ __| __| | '_ \/ __| __/ _\` | | |"
echo "| |_) | (_) \__ \ |_| | | | \__ \ || (_| | | |"
echo "| .__/ \___/|___/\__|_|_| |_|___/\__\__,_|_|_|"
echo "|_|"
echo -e "\nMoros postinstall script"
echo -e "\n=================================\n"


# Creating directories
echo "-------------------------------------------------"
echo "--------------creating directories---------------"
echo "-------------------------------------------------"
mkdir ~/Desktop
mkdir ~/Documents
mkdir ~/Downloads
mkdir ~/Music
mkdir ~/Pictures
mkdir ~/Videos
mkdir ~/.bin


# Building paru
echo "-------------------------------------------------"
echo "------------------building paru------------------"
echo "-------------------------------------------------"
cd ~/.bin
sudo pacman -S base-devel --noconfirm --needed
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si


# Install and configure sddm
echo "-------------------------------------------------"
echo "-----------------installing sddm-----------------"
echo "-------------------------------------------------"
paru -S sddm qt5‑graphicaleffects qt5‑quickcontrols2 qt5‑svg --noconfirm --needed
sudo systemctl enable sddm
cd /usr/share/sddm/themes
git clone https://github.com/MacKenzie779/sddm-sugar-candy
cd /etc
mkdir sddm.conf.d
cd sddm.conf.d
git clone https://github.com/MacKenzie779/sddmconf
cd sddmconf
mv sddm.conf ..


# Install and configure sway
echo "-------------------------------------------------"
echo "-----------------installing sway-----------------"
echo "-------------------------------------------------"
paru -S sway nordic-theme i3status nerd-fonts-jetbrains-mono ttf-jetbrains-mono rofi-lbonn-wayland-git nautilus gthumb qt5-styleplugins qt5ct kwayland --noconfirm --needed

echo "Deploying conf"
cd ~/.bin
git clone https://github.com/MacKenzie779/archconf.git
cd archconf
cp -R .config ~/.config


# Install and configure zsh
echo "-------------------------------------------------"
echo "-----------------installing zsh------------------"
echo "-------------------------------------------------"
paru -S alacritty zsh
cd ~/.config
mv .zshrc ..
mv .bashrc ..
mv .gitconfig ..


# Configure zsh
echo "-------------------------------------------------"
echo "-----------------configure rofi------------------"
echo "-------------------------------------------------"
cd ~/.bin
git clone https://github.com/lr-tech/rofi-themes-collection.git
cd rofi-themes-collection
mkdir -p ~/.local/share/rofi/themes/
cp themes/squared-nord.rasi ~/.local/share/rofi/themes/


#installing other stuff
echo "-------------------------------------------------"
echo "-------------installing other stuff--------------"
echo "-------------------------------------------------"
paru -S nemo swaylock-effects-git swayidle brightnessctl pulseaudio pavucontrol --noconfirm --needed


#reboot
echo "-------------------------------------------------"
echo "-----------------rebooting now-------------------"
echo "-------------------------------------------------"
#reboot