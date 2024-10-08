paru -S hyprland hyprpaper hyprlock hyprshot automake --noconfirm --needed
# rofi for wayland
paru -S fuzzel --noconfirm --needed
# status bar
paru -S waybar --noconfirm --needed
# terminal
paru -S kitty --noconfirm --needed
# icons
paru -S kora-icon-theme phinger-cursors --noconfirm --needed
# notification deamon
paru -S dunst --noconfirm --needed
# cmd line utility for controlling media players
paru -S playerctl --noconfirm --needed
# file explorer
paru -S nemo --noconfirm --needed
# gnome desktop manager
paru -S gdm --noconfirm --needed
sudo systemctl enable gdm
echo "Deploying config by GamingGuy003"
cd ~/.bin
git clone https://github.com/GamingGuy003/configs-dotfiles
cd configs-dotfiles/fedora/hyprland
mv dotfiles ~/.config