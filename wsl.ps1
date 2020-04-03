Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -NoRestart

# restart!

scoop install archwsl
arch

wsl sed -i '85s/#//' /etc/sudoers
wsl useradd -m -G wheel matheus
arch config --default-user matheus
wsl passwd matheus

wsl sudo pacman-key --init
wsl sudo pacman-key --populate archlinux
wsl sudo pacman -Syyu --noconfirm

wsl sudo pacman -Sy git --noconfirm
wsl sudo pacman -Sy openssh --noconfirm
wsl sudo pacman -Sy kakoune --noconfirm
