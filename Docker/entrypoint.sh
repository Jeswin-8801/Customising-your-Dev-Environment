#!/bin/sh

# installs NVM (Node Version Manager)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash -s
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# download and install Node.js
nvm install 20

mkdir -p $HOME/downloads

# OhMyPosh setup
wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/download/v19.29.0/posh-linux-amd64 -P $HOME/ohmyposh -S
chmod +x $HOME/ohmyposh/posh-linux-amd64
wget https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/tokyonight_storm.omp.json -P $HOME/ohmyposh

echo "
alias ll=\"lsd -alhtr\"
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
" >>$HOME/.bash_aliases

echo "
# OhMyPosh Theme
eval \"\$($HOME/ohmyposh/posh-linux-amd64 init bash --config $HOME/ohmyposh/tokyonight_storm.omp.json)\"
" >>$HOME/.bashrc

# lazygit
wget https://github.com/jesseduffield/lazygit/releases/download/v0.41.0/lazygit_0.41.0_Darwin_arm64.tar.gz -O $HOME/downloads/lazygit.tar.gz -S
tar -xvzf $HOME/downloads/lazygit.tar.gz -C $HOME/downloads
apt-get install $HOME/downloads/lazygit

# lazyvim
git clone https://github.com/LazyVim/starter $HOME/.config/nvim
rm -rf $HOME/.config/nvim/.git

# --------------------------------------------------------------------------------------

# ssh-keygen -A
# https://www.ssh.com/academy/ssh/sshd#startup-and-roles-of-different-sshd-processes
ssh-keygen -t rsa -b 4096 -f $HOME/.ssh/ssh_host_rsa_key -N ""

# Port 2200

echo "HostKey $HOME/.ssh/ssh_host_rsa_key

LogLevel DEBUG
PasswordAuthentication yes
PermitRootLogin no
MaxSessions 2
AllowTcpForwarding yes
AllowStreamLocalForwarding yes
GatewayPorts yes" >>$HOME/.ssh/sshd_config

echo "----------------------------------- starting sshd"

# view system logs => less /var/log/syslog

mkdir -p $HOME/.ssh/log

exec /usr/sbin/sshd -D -f $HOME/.ssh/sshd_config -E $HOME/.ssh/log/auth.log
