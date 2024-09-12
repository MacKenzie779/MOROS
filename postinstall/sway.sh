
# Install and configure sddm
echo "-------------------------------------------------"
echo "-----------------installing sddm-----------------"
echo "-------------------------------------------------"
paru -S sddm qt5-graphicaleffects qt5-quickcontrols2 qt5-svg --noconfirm --needed
sudo systemctl enable sddm
cd /usr/share/sddm/themes
sudo git clone https://github.com/MacKenzie779/sddm-sugar-candy
cd /etc
sudo mkdir sddm.conf.d
cd sddm.conf.d
sudo git clone https://github.com/MacKenzie779/sddmconf
cd sddmconf
sudo mv sddm.conf ..


# Install and configure sway
echo "-------------------------------------------------"
echo "-----------------installing sway-----------------"
echo "-------------------------------------------------"
paru -S sway nordic-theme i3status ttf-jetbrains-mono rofi-lbonn-wayland-git nautilus gthumb qt5-styleplugins qt5ct kwayland --noconfirm --needed

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

