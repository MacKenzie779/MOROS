#!/usr/bin/env bash
source "utils/color-definition.sh"
source "utils/printf.sh"
source "utils/scanf.sh"


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
sudo pacman -Sy base-devel --noconfirm --needed
cd ~/.bin
git clone https://aur.archlinux.org/paru-bin.git
cd paru-bin
makepkg -si


println_imp "-------------------------------------------------"
println_imp "------------------Select Desktop-----------------"
println_imp "-------------------------------------------------"

println_imp "Select desktop"
println_imp "1 -> Gnome"
println_imp "2 -> Sway (Wayland)"
println_err "3 -> Hyprland !!NOT IMPLEMENTED!!"
scanf "Your selection: "

case "$SCANF" in 
    "1")
        source "postinstall/sway.sh"
        ;;
    "2")
        source "postinstall/gnome.sh"
        ;;
    *)
        println_err "No valid selection"
        ;;
esac

println_imp "-------------------------------------------------"
println_imp "------Postinstall finished - REBOOTING NOW-------"
println_imp "-------------------------------------------------"
reboot