#!/bin/bash

sudo apt update
sudo apt full-upgrade
sudo apt autoremove

mkdir -p ~/temp

# lsd
wget https://github.com/lsd-rs/lsd/releases/download/v1.1.2/lsd-musl_1.1.2_amd64.deb -O ~/temp/lsd.deb -S
sudo apt install ~/temp/lsd.deb

# oh my posh
sudo curl -s https://ohmyposh.dev/install.sh | sudo bash -s
mkdir -p ~/.fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip -O ~/temp/JetBrainsMono.zip -S
unzip -f ~/temp/JetBrainsMono.zip -d ~/.fonts
fc-cache -fv
wget https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/tokyonight_storm.omp.json -P ~/ohmyposh

# neovim
wget https://github.com/neovim/neovim/releases/download/v0.9.5/nvim-linux64.tar.gz -O ~/temp/nvim.tar.gz -S
sudo tar -xvzf ~/temp/nvim.tar.gz -C /opt/
sudo ln -s /opt/nvim-linux64/bin/nvim /usr/local/bin/nvim

# .profile
echo "
# OhMyPosh Theme
eval \"\$(oh-my-posh init bash --config ~/ohmyposh/tokyonight_storm.omp.json)\"

# custom aliases
alias ll=\"lsd -ltrh\"
alias c=\"clear\"
alias cls=\"clear\"
alias ..='cd ..'
alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../../'
alias .2='cd ../../'
alias .3='cd ../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../../'
" >> ~/.profile

# lazygit
wget https://github.com/jesseduffield/lazygit/releases/download/v0.41.0/lazygit_0.41.0_Darwin_arm64.tar.gz -O ~/temp/lazygit.tar.gz -S
sudo tar -xvzf ~/temp/lazygit.tar.gz -C ~/temp
sudo apt-get install ~/temp/lazygit

rm -rf ~/temp

# lazyvim
git clone https://github.com/Jeswin-8801/My-Neovim-Config ~/.config/nvim
