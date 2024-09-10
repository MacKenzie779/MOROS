#!/usr/bin/env bash

#greeting
echo "                                          _                     _"
echo " _ __ ___   ___  _ __ ___  ___        ___| |__  _ __ ___   ___ | |_"
echo "| '_ \` _ \ / _ \| '__/ _ \/ __|_____ / __| '_ \| '__/ _ \ / _ \| __|"
echo "| | | | | | (_) | | | (_) \__ \_____| (__| | | | | | (_) | (_) | |_"
echo "|_| |_| |_|\___/|_|  \___/|___/      \___|_| |_|_|  \___/ \___/ \__|"
echo -e "\narch-chroot configuration script"
echo -e "\n=================================\n"


#configure base system
echo "-------------------------------------------------"
echo "--------------Configure base system--------------"
echo "-------------------------------------------------"

echo "Set Timezone to Europe/Berlin"
ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime
hwclock --systohc

echo "Generating locales"
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "KEYMAP=de-latin1" >> /etc/vconsole.conf

echo "Network configuration"
echo "arch" >> /etc/hostname
pacman -S networkmanager --noconfirm --needed
systemctl enable NetworkManager

echo "Generating initramfs"
mkinitcpio -P


# Configure user accounts
echo "-------------------------------------------------"
echo "-------------Setting up user account-------------"
echo "-------------------------------------------------"

echo "Set root passwd"
echo "user" | passwd --stdin
pacman -S sudo --noconfirm --needed

echo "Create user account for user user"
useradd -m -G wheel -s /bin/bash user

echo "Set user passwd"
echo "user" | passwd --stdin user
cat "%wheel ALL=(ALL:ALL) ALL" >> /etc/sudoers


# Install Bootloader
echo "-------------------------------------------------"
echo "-----------------Setting up grub-----------------"
echo "-------------------------------------------------"
pacman -S efibootmgr grub --noconfirm --needed
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB_arch
echo "GRUB_DISABLE_OS_PROBER=false" >> /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg


#Setup finished
echo "-------------------------------------------------"
echo "----------------EXIT arch-chroot-----------------"
echo "-------------------------------------------------"
exit