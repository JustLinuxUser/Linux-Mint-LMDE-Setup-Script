# Linux-Mint-Setup-Scripts
## Help:
- [LMDE Installation settings](./LMDE_INSTALL.md) s
- [Script ussage](./USSAGE.md) 
## This script handles:
### Packages
- Installs third-party .deb packages (protonVPN)
- Updates package database
- Upgrades all installed packages
- Installs additional packages
- Installs packages via flatpak

### Ukrainian localisation
- Downloads Ukrainian localisation packages
- Adds Ukrainian locale to /etc/locale.gen
- Regenerates locale
- Sets up dotfiles(.dmrc .xsessionrc) to ukrainian locale
- Sets keyboard layout
- Sets keyboard shortcut
- Renames user directories(Downloads Desktop etc.) to Ukrainian
- Deletes Spanish user directories

### DNS
- Deletes /etc/resolv.conf
- Creates dir /etc/resolv/
- Writes "nameserver 8.8.8.8" to /etc/resolv/resolv.conf
- Links /etc/resolv/resolv.conf to /etc/resolv.conf

### Files
- Copy files from to-desktop/ to newly created desktop
