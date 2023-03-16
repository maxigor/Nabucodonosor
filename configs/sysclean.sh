#!/bin/bash

#Removes packages that are no longer needed as dependencies by other packages. Specifically, it removes all packages that are not required by explicitly installed packages or explicitly selected packages. The paru -Qtdq part lists all packages that are not dependencies of any installed packages, and the $(...) syntax substitutes the output of that command as arguments to the paru -Rscn command to remove them.
paru -Rscn $(paru -Qtdq)

#Updates the locate database, which is used to quickly search for files on the system by name.
sudo updatedb

#Updates the pkgfile database, which is used to quickly search for packages that provide specific files.
sudo pkgfile -u 

#Updates the package lists for the paru package manager, which is an AUR helper for Arch Linux.
paru -Fyy

#Upgrades the local package database for the pacman package manager, which is the default package manager for Arch Linux.
sudo pacman-db-upgrade

#Clears the package cache for paru. The yes command provides a positive answer to a prompt that asks if the user wants to remove all cached packages. The paru -Scc part actually removes the cached packages.
yes | paru -Scc

#Writes any pending changes to the file system to disk, ensuring that all data is safely written to disk before any further operations are performed.
sudo sync
