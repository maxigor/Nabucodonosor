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

PKGS=(

"
-------------------------------------------------------------------------
                        Installing system 
-------------------------------------------------------------------------
"
   
    'linux-lts-headers'
    'linux-lts'             # Long term support kernel
    'base-devel'            # important
    'nautilus'              # file manager
    'bspwm'                 # Window Manager
    'sxhkd'                 # Hotkey Daemon
    'networkmanager'

"

-------------------------------------------------------------------------
                         Terminal Utilities 
-------------------------------------------------------------------------
"

    'bash-completion'       # Tab completion for Bash
    'bc'                    # Precision calculator language
    'bleachbit'             # File deletion utility
    'curl'                  # Remote content retrieval
    'elinks'                # Terminal based web browser
    'feh'                   # Terminal-based image viewer/manipulator
    'file-roller'           # Archive utility
    'keepassxc'             # Password storage
    'gtop'                  # System monitoring via terminal
    'gufw'                  # Firewall manager
    'hardinfo'              # Hardware info app
    'htop'                  # Process viewer
    'inxi'                  # System information utility
    'jq'                    # JSON parsing library
    'jshon'                 # JSON parsing library
    'neofetch'              # Shows system info when you launch terminal
    'ntp'                   # Network Time Protocol to set time via network.
    'openssh'               # SSH connectivity tools
    'rsync'                 # Remote file sync utility
    'speedtest-cli'         # Internet speed via terminal
    'terminus-font'         # Font package with some bigger fonts for login terminal
    'unrar'                 # RAR compression program
    'unzip'                 # Zip compression program
    'wget'                  # Remote content retrieval
    'alacritty'             # Terminal emulator
    'zenity'                # Display graphical dialog boxes via shell scripts
    'zip'                   # Zip compression program
    'zsh'                   # ZSH shell
    'zsh-completions'       # Tab completion for ZSH
    'starship'              # Customizable prompt
    'github-cli'            # github cli helper
    'usbutils'		        # usb utilities 
    'net-tools'
    'openvpn'	            # OpenVPN
    'starship'
    'exa'

"
-------------------------------------------------------------------------
                          Disk Utilities 
-------------------------------------------------------------------------
"

    'exfat-utils'           # Mount exFat drives
    'gparted'               # Disk utility
    'ntfs-3g'               # Open source implementation of NTFS file system
    'parted'                # Disk utility


"
-------------------------------------------------------------------------
                          General Utilities
-------------------------------------------------------------------------
"

    'nemo'                  # Filesystem browser
    'veracrypt'             # Disc encryption utility
    'variety'               # Wallpaper changer
    'polybar'               # Status Bar
    'qbittorrent'           # Torrent
    'font-manager'          # Font Manager
    'papirus-icon-theme'
    'flameshot'             # Screenshot
    'rofi'
    'plank'
    'dunst'
    'jgmenu'
    
    
"
-------------------------------------------------------------------------
                            Development
-------------------------------------------------------------------------
" 
    'vim'                   # Text editor
    'neovim'                # Text editor
    'apache'                # Apache web server
    'clang'                 # C Lang compiler
    'cmake'                 # Cross-platform open-source make system
    'electron'              # Cross-platform development using Javascript
    'git'                   # Version control system
    'gcc'                   # C/C++ compiler
    'glibc'                 # C libraries
    'mariadb'               # Drop-in replacement for MySQL
    #'meld'                # File/directory comparison
    'nodejs'                # Javascript runtime environment
    'npm'                   # Node package manager
    #'php'                   # Web application scripting language
    #'php-apache'            # Apache PHP driver
    #'postfix'             # SMTP mail server
    'python'                # Scripting language
    'python-pip'
    'qtcreator'           # C++ cross platform IDE
    'qt5-examples'        # Project demos for Qt
    'aws-cli'
"
-------------------------------------------------------------------------
                           Web Tools 
-------------------------------------------------------------------------
"

    'firefox'               # Web browser
    'filezilla'             # FTP Client
    'thunderbird'
"
-------------------------------------------------------------------------
                          Communications 
-------------------------------------------------------------------------
"

    'hexchat'               # Multi format chat
    'irssi'                 # Terminal based IIRC
"
-------------------------------------------------------------------------
                            Media 
-------------------------------------------------------------------------
"

    'simplescreenrecorder'  # Record your screen
    'vlc'                   # Video player
    'pavucontrol'
    'pulseaudio'
    'alsa-utils' 
   
"
-------------------------------------------------------------------------
                        Graphics and Design
-------------------------------------------------------------------------
" 

    'gcolor2'               # Colorpicker
    'gimp'                  # GNU Image Manipulation Program
    'inkscape'              # Vector image creation app
    'imagemagick'           # Command line image manipulation tool
    'nomacs'                # Image viewer
    'pngcrush'              # Tools for optimizing PNG images
    'ristretto'             # Multi image viewer

"
-------------------------------------------------------------------------
                     Picom Pijulus Dependencies
-------------------------------------------------------------------------
" 

    'libconfig'
    'libev'
    'libxdg-basedir'
    'pcre'
    'pixman'
    'xcb-util-image'
    'xcb-util-renderutil'
    'hicolor-icon-theme'
    'libglvnd'
    'libx11'
    'libxcb'
    'libxext'
    'libdbus'
    'asciidoc'
    'uthash'

"
-------------------------------------------------------------------------
                           Productivity
-------------------------------------------------------------------------
"

    'galculator'            # Gnome calculator
    'hunspell'              # Spellcheck libraries
    'hunspell-en'           # English spellcheck library
    'libreoffice-fresh'     # Libre office with extra features
    'xpdf'                  # PDF viewer
  
"
-------------------------------------------------------------------------
                              Fonts
-------------------------------------------------------------------------
"

    'ttf-font-awesome'
    'ttf-roboto'
    'ttf-roboto-mono'

"
-------------------------------------------------------------------------
                            Bluetooth
-------------------------------------------------------------------------
"
    
    'bluez'
    'bluez-utils'

"
-------------------------------------------------------------------------
                          Virtualization
-------------------------------------------------------------------------
"

    'virtualbox'
    'virtualbox-guest-utils'
    'virtualbox-host-modules-arch'
)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo pacman -S "$PKG" --noconfirm --needed
done
    
echo
echo "Done!"
echo

echo -ne "
-------------------------------------------------------------------------
                        Installing AUR Packages
-------------------------------------------------------------------------
"
