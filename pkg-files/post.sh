#!/usr/bin/env bash
echo -ne "
------------------------------------------------------------------------------------------------------------------

███╗   ██╗ █████╗ ██████╗ ██╗   ██╗ ██████╗ ██████╗ ██████╗  ██████╗ ███╗   ██╗ ██████╗ ███████╗ ██████╗ ██████╗ 
████╗  ██║██╔══██╗██╔══██╗██║   ██║██╔════╝██╔═══██╗██╔══██╗██╔═══██╗████╗  ██║██╔═══██╗██╔════╝██╔═══██╗██╔══██╗
██╔██╗ ██║███████║██████╔╝██║   ██║██║     ██║   ██║██║  ██║██║   ██║██╔██╗ ██║██║   ██║███████╗██║   ██║██████╔╝
██║╚██╗██║██╔══██║██╔══██╗██║   ██║██║     ██║   ██║██║  ██║██║   ██║██║╚██╗██║██║   ██║╚════██║██║   ██║██╔══██╗
██║ ╚████║██║  ██║██████╔╝╚██████╔╝╚██████╗╚██████╔╝██████╔╝╚██████╔╝██║ ╚████║╚██████╔╝███████║╚██████╔╝██║  ██║
╚═╝  ╚═══╝╚═╝  ╚═╝╚═════╝  ╚═════╝  ╚═════╝ ╚═════╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝ ╚══════╝ ╚═════╝ ╚═╝  ╚═╝
                        Arch Linux Post Install Setup and Config
-----------------------------------------------------------------------------------------------------------------
"


echo -ne "
-------------------------------------------------------------------------
                        Copying Essencial Files 
-------------------------------------------------------------------------
"
echo "Copying Files..."
mkdir /home/max/Downloads

cp -r /home/max/nabucodonosor/configs/.config /home/max/
cp /home/max/nabucodonosor/configs/.Xresources /home/max/
cp /home/max/nabucodonosor/configs/.xinitrc /home/max/
cp /home/max/nabucodonosor/configs/.zshrc /home/max/

echo "done"

#XQP -----------------------------------------------------------------
cd /home/max/Downloads
git clone https://github.com/baskerville/xqp.git
cd xqp
make
sudo make install

# XDO -----------------------------------------------------------------
cd /home/max/Downloads
git clone https://github.com/baskerville/xdo
cd xdo
make
sudo make install

sudo usermod -aG adm $USER

# FONTS INSTALL ------------------------------------------------------
sudo cp -r /home/max/nabucodonosor/configs/.fonts/* /usr/share/fonts/TTF sudo fc-cache -fv 

# NVIDIA XORG FILE ---------------------------------------------------- 
sudo cp /home/max/nabucodonosor/configs/20-nvidia.conf /etc/X11/xorg.conf.d/

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
echo -e "Copying the theme..."
cd ${HOME}/nabucodonosor
cp -a configs${THEME_DIR}/${THEME_NAME}/* ${THEME_DIR}/${THEME_NAME}
echo -e "Backing up Grub config..."
cp -an /etc/default/grub /etc/default/grub.bak
echo -e "Setting the theme as the default..."
grep "GRUB_THEME=" /etc/default/grub 2>&1 >/dev/null && sed -i '/GRUB_THEME=/d' /etc/default/grub
echo "GRUB_THEME=\"${THEME_DIR}/${THEME_NAME}/theme.txt\"" >> /etc/default/grub
echo -e "Updating grub..."
grub-mkconfig -o /boot/grub/grub.cfg
echo -e "All set!"


echo -ne "
-------------------------------------------------------------------------
                    Enabling Essential Services
-------------------------------------------------------------------------
"

echo "Changed default shell to ZSH!"
chsh -s $(which zsh)

echo "Enabling NetworkManager"
systemctl enable NetworkManager.service

echo "Enabling Ly Display Manager..."
sudo systemctl enable ly.service
sudo cp /home/max/nabucodonosor/configs/config.ini /etc/ly/

echo "Enabling and Starting Plex Media Service..."
sudo systemctl enable plexmediaserver
sudo systemctl start plexmediaserver

echo "Enabling and Starting NordVPN..."
groupadd -r nordvpn
sudo usermod -aG nordvpn $USER
sudo systemctl enable nordvpnd.service
sudo systemctl start nordvpnd.service

echo "enabling virtualbox service"
sudo systemctl enable vboxservice.service

modprobe btusb
echo "enabling and starting bluetooth service..."
sudo systemctl enable bluetooth
sudo systemctl start bluetooth

echo -ne "
-------------------------------------------------------------------------
                        Setting up Git Account
-------------------------------------------------------------------------
"

echo "Configuring git email and user..."
git config --global user.email "maxigor.ferreira@gmail.com"
git config --global user.name "Max"

echo "done"
