#!/usr/bin/env bash

#greeting
echo -e "Welcome to\n"
echo " _ __ ___   ___  _ __ ___  ___"
echo "| '_ \` _ \ / _ \| '__/ _ \/ __|"
echo "| | | | | | (_) | | | (_) \__ \ "
echo "|_| |_| |_|\___/|_|  \___/|___/"
echo -e "\nBasic ArchLinux Setup Script"
echo -e "\n================================================\n"


#init
echo "-------------------------------------------------"
echo "-----------------Initialization------------------"
echo "-------------------------------------------------"

echo "-----------set console keyboard layout-----------"
loadkeys de

echo "-----setting up mirrors for optimal download-----"
timedatectl set-ntp true
pacman-key --init
pacman-key --populate
pacman -Syyy
pacman -S pacman-contrib --noconfirm
mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
curl -s "https://archlinux.org/mirrorlist/?country=DE&protocol=https&use_mirror_status=on" | sed -e 's/^#Server/Server/' -e '/^#/d' | rankmirrors -n 5 - > /etc/pacman.d/mirrorlist


#partitioning
echo "-------------------------------------------------"
echo "------------------Partitioning-------------------"
echo "-------------------------------------------------"
lsblk
fdisk -l
echo -e "\nPlease enter disk: (example /dev/sda)"
read DISK
echo -e "\nChoose your partition scheme (for more information see README.md):"
echo "1 -> Laptop dualboot"
echo "2 -> Desktop"
echo "3 -> VM"
echo "4 -> exit (default)"
read PART_PROF
case "$PART_PROF" in 
    "1")
        echo "You selected: Laptop dualboot partition scheme"
        echo "${DISK} will be wiped and following partition table will be applied"
        echo "+-------------+------------------------+------------+"
        echo "| Mount point | Size                   | Filesystem |"
        echo "+-------------+------------------------+------------+"
        echo "| /boot       | 1 GiB (for dualboot)   | FAT32      |"
        echo "+-------------+------------------------+------------+"
        echo "| SWAP        | 32 GiB (2 x RAM)       | SWAP       |"
        echo "+-------------+------------------------+------------+"
        echo "| /           | 1/3 of free disk space | EXT4       |"
        echo "+-------------+------------------------+------------+"
        echo "| /home       | 2/3 of free disk space | EXT4       |"
        echo "+-------------+------------------------+------------+"

        echo -e "\nContinue? y/n"
        read OK
        if [ "$OK" = "n" ]; then 
            echo "abort installation ..."
            exit 0
        fi

        echo "---------------Creating partitions---------------"
        echo "Create new GPT partition table"
        parted -s ${DISK} mklabel gpt
        echo "Create a 1 GiB EFI System partition for /boot"
        parted -s ${DISK} mkpart ESP fat32 1MiB 1025MiB
        parted -s ${DISK} set 1 esp on
        echo "Create a 32 GiB swap partition"
        parted -s ${DISK} mkpart primary linux-swap 1025MiB 33793MiB
        echo "Create a root partition using 1/3 of the remaining free space"
        # First, calculate the start and end sectors
        free_space_start=33793
        total_size=$(parted -m ${DISK} unit MiB print free | grep -E '^ [[:digit:]]' | tail -n 1 | cut -d ':' -f 2 | sed 's/MiB//')
        root_partition_end=$(( free_space_start + ((total_size - free_space_start) / 3) ))
        parted -s ${DISK} mkpart primary ext4 ${free_space_start}MiB ${root_partition_end}MiB
        echo "Create a home partition with the remaining space (2/3 of the free space)"
        parted -s ${DISK} mkpart primary ext4 ${root_partition_end}MiB 100%

        echo "---------------Formatting partitions---------------"
        echo "Boot-Partition: FAT32 on ${DISK}p1"
        mkfs.fat -F 32 "${DISK}p1"
        echo "SWAP on ${DISK}p2"
        mkswap "${DISK}p2"
        echo "Root-Partition: ext4 on ${DISK}p3"
        mkfs.ext4 "${DISK}p3"
        echo "Home-Partition: ext4 on ${DISK}p4"
        mkfs.ext4 "${DISK}p4"

        echo "---------------Mounting partitions---------------"
        echo "Mounting root partition to /mnt"
        mount ${DISK}p3 /mnt
        echo "Mounting boot partition to /mnt/boot"
        mount --mkdir ${DISK}p1 /mnt/boot
        echo "Mounting home partition to /mnt/home"
        mount --mkdir ${DISK}p4 /mnt/home
        echo "Activating swap"
        swapon ${DISK}p2
        ;;
    "2")
        echo "You selected: Desktop partition scheme"
        echo "Error: not implemented"
        echo "abort installation ..."
        exit 1
        ;;
    "3") 
        echo "You selected: VM partition scheme"
        echo "${DISK} will be wiped and following partition table will be applied"
        echo "+-------------+-------------------------+------------+"
        echo "| Mount point | Size                    | Filesystem |"
        echo "+-------------+-------------------------+------------+"
        echo "| /boot       | 512 MiB                 | FAT32      |"
        echo "+-------------+-------------------------+------------+"
        echo "| /           | 100% of free disk space | EXT4       |"
        echo "+-------------+-------------------------+------------+"
    
        echo -e "\nContinue? y/n"
        read OK
        if [ "$OK" = "n" ]; then 
            echo "abort installation ..."
            exit 0
        fi

        echo "---------------Creating partitions---------------"
        echo "Create new GPT partition table"
        parted -s ${DISK} mklabel gpt
        echo "Create a 512 MiB EFI System partition for /boot"
        parted -s ${DISK} mkpart ESP fat32 1MiB 513MiB
        parted -s ${DISK} set 1 esp on
        echo "Create a root partition with the remaining space"
        parted -s ${DISK} mkpart primary ext4 513MiB 100%

        echo "---------------Formatting partitions---------------"
        echo "Boot-Partition: FAT32 on ${DISK}1"
        mkfs.fat -F 32 "${DISK}1"
        echo "Root-Partition: ext4 on ${DISK}2"
        mkfs.ext4 "${DISK}2"

        echo "---------------Mounting partitions---------------"
        echo "Mounting root partition to /mnt"
        mount ${DISK}2 /mnt
        echo "Mounting boot partition to /mnt/boot"
        mount --mkdir ${DISK}1 /mnt/boot
        ;;
    *)
        echo "exit"
        echo "abort installation ..."
        exit 0
        ;;
esac


# Installing
echo "-------------------------------------------------"
echo "-------------Installing Base System--------------"
echo "-------------------------------------------------"
echo "Select kernel"
echo "1 -> Stable — Vanilla Linux kernel and modules, with a few patches applied (default)"
echo "2 -> Longterm — Long-term support (LTS) Linux kernel and modules with configuration options targeting usage in servers"
read KERNEL
case "$KERNEL" in
    "1") 
        echo "Installing rolling release kernel"
        pacstrap -K /mnt base linux linux-firmware git vim nano htop --noconfirm --needed
        ;;
    "2")
        echo "Installing lts kernel"
        pacstrap -K /mnt base linux-lts linux-firmware git vim nano htop --noconfirm --needed
        ;;
    *)
        echo "Installing rolling release kernel"
        pacstrap -K /mnt base linux linux-firmware git vim nano htop --noconfirm --needed
        ;;
esac


#configure base system
echo "-------------------------------------------------"
echo "-------------Chroot into new system-------------"
echo "-------------------------------------------------"

echo "Generating fstab"
genfstab -U /mnt >> /mnt/etc/fstab

echo "Chroot into new system"
# copy script into the system available after chrooting
cp setup-chroot.sh /mnt/setup-chroot.sh
chmod +x /mnt/setup-chroot.sh
cp postinstall.sh /mnt/postinstall.sh
chmod +x /mnt/postinstall.sh
# the ./setup-chroot is referencing /mnt/setup-chroot.sh
arch-chroot /mnt /bin/bash -c "./setup-chroot.sh"


#reboot
#echo "-------------------------------------------------"
#echo "-----------------REBOOTING NOW!------------------"
#echo "-------------------------------------------------"
umount -R /mnt
reboot