#!/usr/bin/env bash
#github-action genshdoc
#
# @file Post-Setup
# @brief Finalizing installation configurations and cleaning up after script.
echo -ne "
-------------------------------------------------------------------------
#     #                                                                                     
##    #   ##   #####  #    #  ####   ####  #####   ####  #    #  ####   ####   ####  #####  
# #   #  #  #  #    # #    # #    # #    # #    # #    # ##   # #    # #      #    # #    # 
#  #  # #    # #####  #    # #      #    # #    # #    # # #  # #    #  ####  #    # #    # 
#   # # ###### #    # #    # #      #    # #    # #    # #  # # #    #      # #    # #####  
#    ## #    # #    # #    # #    # #    # #    # #    # #   ## #    # #    # #    # #   #  
#     # #    # #####   ####   ####   ####  #####   ####  #    #  ####   ####   ####  #    # 
-------------------------------------------------------------------------

                    Automated Arch Linux Installer
                        SCRIPTHOME: nabucodonosor
-------------------------------------------------------------------------

Final Setup and Configurations
GRUB EFI Bootloader Install & Check
"
source ${HOME}/nabucodonosor/configs/setup.conf

if [[ -d "/sys/firmware/efi" ]]; then
	grub-install --efi-directory=/boot ${DISK}
fi

echo -ne "
-------------------------------------------------------------------------
               Creating (and Theming) Grub Boot Menu
-------------------------------------------------------------------------
"
# set kernel parameter for decrypting the drive
if [[ "${FS}" == "luks" ]]; then
	sed -i "s%GRUB_CMDLINE_LINUX_DEFAULT=\"%GRUB_CMDLINE_LINUX_DEFAULT=\"cryptdevice=UUID=${ENCRYPTED_PARTITION_UUID}:ROOT root=/dev/mapper/ROOT %g" /etc/default/grub
fi
# set kernel parameter for adding splash screen
sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="[^"]*/& splash /' /etc/default/grub

echo -e "Installing CyberRe Grub theme..."
THEME_DIR="/boot/grub/themes"
THEME_NAME=CyberRe
echo -e "Creating the theme directory..."
mkdir -p "${THEME_DIR}/${THEME_NAME}"
echo -e "Copying the theme.. e."
cd ${HOME}/nabucodonosor
cp -a configs${THEME_DIR}/${THEME_NAME}/* ${THEME_DIR}/${THEME_NAME}
echo -e "Backing up Grub config..."
cp -an /etc/default/grub /etc/default/grub.bak
echo -e "Setting the theme as the default..."
grep "GRUB_THEME=" /etc/default/grub 2>&1 >/dev/null && sed -i '/GRUB_THEME=/d' /etc/default/grub
echo "GRUB_THEME=\"${THEME_DIR}/${THEME_NAME}/theme.txt\"" >>/etc/default/grub
echo -e "Updating grub..."
cp -r ${HOME}/nabucodonosor/configs/default/grub /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg
echo -e "All set!"

echo -ne "
-------------------------------------------------------------------------
                        Installing Fonts
-------------------------------------------------------------------------
"
cd ~/Downloads/
git clone https://github.com/maxigor/fonts
sudo cp -r fonts/* /usr/share/fonts/TTF/
sudo fc-cache -fv

echo -ne "
-------------------------------------------------------------------------
                        Symlink directory
-------------------------------------------------------------------------
"
ln -s /home/$USERNAME/nabucodonosor/configs/.config/alacritty /home/$USERNAME/.config/
ln -s /home/$USERNAME/nabucodonosor/configs/.config/bspwm /home/$USERNAME/.config/
ln -s /home/$USERNAME/nabucodonosor/configs/.config/dunst /home/$USERNAME/.config/
ln -s /home/$USERNAME/nabucodonosor/configs/.config/neofetch /home/$USERNAME/.config/
ln -s /home/$USERNAME/nabucodonosor/configs/.config/nvim /home/$USERNAME/.config/
ln -s /home/$USERNAME/nabucodonosor/configs/.config/polybar /home/$USERNAME/.config/
ln -s /home/$USERNAME/nabucodonosor/configs/.config/qBittorrent /home/$USERNAME/.config/
ln -s /home/$USERNAME/nabucodonosor/configs/.config/rofi /home/$USERNAME/.config/
ln -s /home/$USERNAME/nabucodonosor/configs/.config/sxhkd /home/$USERNAME/.config/
ln -s /home/$USERNAME/nabucodonosor/configs/.config/wallpaper /home/$USERNAME/.config/
ln -s /home/$USERNAME/nabucodonosor/configs/.config/.fehbg /home/$USERNAME/.config/
ln -s /home/$USERNAME/nabucodonosor/configs/.config/pavucontrol.ini /home/$USERNAME/.config/
ln -s /home/$USERNAME/nabucodonosor/configs/.config/picom.conf /home/$USERNAME/.config/
ln -s /home/$USERNAME/nabucodonosor/configs/.config/starship.toml /home/$USERNAME/.config/
rm -rf .zshrc
ln -s /home/$USERNAME/nabucodonosor/configs/.zshrc /home/$USERNAME/

echo -ne "
-------------------------------------------------------------------------
                        Setting keyboard layout
-------------------------------------------------------------------------
"

#anne pro 2 pt-br 4 the win
setxkbmap -model abnt -layout us -variant intl
cp {HOME}/nabucodonosor/configs/50-zsa.rules /etc/udev/rules.d/

echo -ne "
-------------------------------------------------------------------------
                        Installing XQP
-------------------------------------------------------------------------
"

cd ~/Downloads
git clone https://github.com/baskerville/xqp.git
cd xqp
make
sudo make install

rm -rf ~/Downloads/xqp

echo -ne "
-------------------------------------------------------------------------
                    Enabling Essential Services
-------------------------------------------------------------------------
"

echo "Enabling NetworkManager"
systemctl enable NetworkManager.service

echo "Enabling Ly Display Manager..."
sudo systemctl enable ly.service

echo "Enabling and Starting Plex Media Service..."
sudo systemctl enable plexmediaserver
sudo systemctl start plexmediaserver

echo "enabling virtualbox service"
sudo systemctl enable vboxservice.service

modprobe btusb
echo "enabling and starting bluetooth service..."
sudo systemctl enable bluetooth
sudo systemctl start bluetooth

echo "enabling and starting Radarr/Sonarr/Bazarr"
sudo systemctl enable radarr.service
sudo systemctl enable sonarr.service
sudo systemctl enable bazarr.service

sudo systemctl start radarr.service
sudo systemctl start sonarr.service
sudo systemctl start bazarr.service

echo "enabling and starting Samba serivce"
sudo systemctl enable smb.service
sudo systemctl start smb.service

echo "enabling libvirtd"
sudo systemctl enable --now libvirtd.service
sudo systemctl start libvirtd.service

echo -ne "
-------------------------------------------------------------------------
                        Setting up DNS
-------------------------------------------------------------------------
"

echo "Configuring NextDNS..."

sed -i '$' /etc/resolv.conf -e "$'nameserver 45.90.28.0'"
sed -i '$' /etc/resolv.conf -e "$'nameserver 45.90.30.0'"

echo "done"

echo -ne "
-------------------------------------------------------------------------
               Enabling (and Theming) Plymouth Boot Splash
-------------------------------------------------------------------------
"
PLYMOUTH_THEMES_DIR="$HOME/nabucodonosor/configs/usr/share/plymouth/themes"
PLYMOUTH_THEME="hexagon_red" # can grab from config later if we allow selection
mkdir -p /usr/share/plymouth/themes
echo 'Installing Plymouth theme...'

cp -rf ${PLYMOUTH_THEMES_DIR}/${PLYMOUTH_THEME} /usr/share/plymouth/themes

sed -i 's/HOOKS=(base udev*/& plymouth/' /etc/mkinitcpio.conf # add plymouth after base udev

plymouth-set-default-theme -R hexagon_red # sets the theme and runs mkinitcpio
echo 'Plymouth theme installed'

echo -ne "
-------------------------------------------------------------------------
                            Nvidia Modules
-------------------------------------------------------------------------
"
gpu_type=$(lspci)
if grep -E "NVIDIA|GeForce" <<<${gpu_type}; then
	sed -i 's/MODULE=(*/& nvidia nvidia_modset nvidia_uvm nvidia_drm/' /etc/mkinitcpio.conf # add nvidia modules
	cp {HOME}/nabucodonosor/configs/70-nvidia.rules /etc/udev/rules.d/
	mkinitcpio -P linux
fi

echo -ne "
------------------------------------------------------------------------
                            Fuck you, Nvidia!
-------------------------------------------------------------------------
"
#fuck u nvidia and ur shitty modules
#pacman -S xf86-video-nouveau --noconfirm

#cp {HOME}/nabucodonosor/configs/20-nouveau.conf /etc/X11/xorg.conf.d/

echo -ne "
-------------------------------------------------------------------------
                    Cleaning
-------------------------------------------------------------------------
"
# Remove no password sudo rights
sed -i 's/^%wheel ALL=(ALL) NOPASSWD: ALL/# %wheel ALL=(ALL) NOPASSWD: ALL/' /etc/sudoers
sed -i 's/^%wheel ALL=(ALL:ALL) NOPASSWD: ALL/# %wheel ALL=(ALL:ALL) NOPASSWD: ALL/' /etc/sudoers
# Add sudo rights
sed -i 's/^# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/' /etc/sudoers
sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers

rm -r /home/$USERNAME/paru

# Replace in the same state
sudo chsh -s $(which /bin/zsh)
timedatectl set-timezone America/Sao_Paulo
cd $pwd
