scoop install archwsl

wsl sed -i '85s/#//' /etc/sudoers
wsl useradd -m -G wheel matheus
arch config --default-user matheus
wsl sudo passwd matheus

wsl sudo pacman-key --init
wsl sudo pacman-key --populate archlinux
wsl sudo pacman -Syyu --noconfirm

wsl sudo pacman -Sy zsh --noconfirm

wsl sudo pacman -Sy openssh --noconfirm
wsl sudo pacman -Sy git --noconfirm
wsl sudo pacman -Sy mercurial --noconfirm

wsl sudo pacman -Sy fzf --noconfirm
wsl sudo pacman -Sy fd --noconfirm
wsl sudo pacman -Sy ripgrep --noconfirm

wsl sudo pacman -Sy neovim --noconfirm
wsl sudo pacman -Sy kakoune --noconfirm
wsl sudo pacman -Sy kak-lsp --noconfirm

wsl sudo pacman -Sy gcc --noconfirm
wsl sudo pacman -Sy rustup --noconfirm
wsl rustup toolchain install stable
wsl cargo install verco

wsl sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
wsl sudo chsh -s /bin/zsh matheus
