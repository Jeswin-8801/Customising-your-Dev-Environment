#!/bin/sh

# installs NVM (Node Version Manager)
curl -o- -s https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash -s
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# download and install Node.js
nvm install 20

# better man pages
npm install -g tldr

mkdir -p $HOME/downloads

# OhMyPosh setup
wget -q https://github.com/JanDeDobbeleer/oh-my-posh/releases/download/v19.29.0/posh-linux-amd64 -P $HOME/ohmyposh -S
chmod +x $HOME/ohmyposh/posh-linux-amd64
wget -q https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/tokyonight_storm.omp.json -P $HOME/ohmyposh

echo "
alias ll=\"lsd -alhtr\"
alias ls=\"nnn -dHoU\"
alias tree=\"lsd --tree -lhtr --depth\"
alias fd=\"fdfind\"
alias bat=\"batcat\"
alias man=\"tldr\"
alias wget=\"wget --progress=dot\"
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

# HSTR configuration
alias hh=hstr                    # hh to be alias for hstr
export HSTR_CONFIG=hicolor       # get more colors
shopt -s histappend              # append new history items to .bash_history
export HISTCONTROL=ignorespace   # leading space hides commands from history
export HISTFILESIZE=10000        # increase history file size (default is 500)
export HISTSIZE=\${HISTFILESIZE}  # increase history size (default is 500)
# ensure synchronization between bash memory and history file
export PROMPT_COMMAND=\"history -a
history -n
\${PROMPT_COMMAND}\"
# if this is interactive shell, then bind hstr to Ctrl-r (for Vi mode check doc)
if [[ \$- =~ .*i.* ]]; then bind '\"\C-r\": \"\C-a hstr -- \C-j\"'; fi
# if this is interactive shell, then bind 'kill last command' to Ctrl-x k
if [[ \$- =~ .*i.* ]]; then bind '\"\C-xk\": \"\C-a hstr -k \C-j\"'; fi
" >>$HOME/.bashrc

echo "
[credential]
    helper = store

[core]
    editor = nvim
    pager = delta

[interactive]
    diffFilter = delta --color-only

[delta]
    navigate = true    # use n and N to move between diff sections
    side-by-side = true
    line-numbers = true
    true-color = always

    # delta detects terminal colors automatically; set one of these to disable auto-detection
    # dark = true
    # light = true

    minus-style = syntax \"#450a15\"
    minus-emph-style = syntax \"#ff0000\"
    plus-style = syntax \"#004010\"
    plus-emph-style = syntax \"#028134\"
    hunk-header-style = syntax
    file-style = yellow
    file-decoration-style = yellow ul

[delta \"interactive\"]
    keep-plus-minus-markers = false

[merge]
    conflictstyle = diff3

[diff]
    colorMoved = default

[alias]
    lg = lg1
    lg1 = lg1-specific --all
    lg2 = lg2-specific --all
    lg3 = lg3-specific --all

    lg1-specific = log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(auto)%d%C(reset)'
    lg2-specific = log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)'
    lg3-specific = log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset) %C(bold cyan)(committed: %cD)%C(reset) %C(auto)%d%C(reset)%n''          %C(white)%s%C(reset)%n''          %C(dim white)- %an <%ae> %C(reset) %C(dim white)(committer: %cn <%ce>)%C(reset)'
" >>$HOME/.gitconfig

echo "
git:
  paging:
    useConfig: false
    pager: delta --dark --paging=never
  commit:
    signOff: false
    autoWrapCommitMessage: true # automatic WYSIWYG wrapping of the commit message as you type
    autoWrapWidth: 72 # if autoWrapCommitMessage is true, the width to wrap to
  merging:
    # extra args passed to \`git merge\`, e.g. --no-ff
    args: \"--no-ff\"
" >>$HOME/.config/lazygit/config.yml

touch $HOME/.tldrrc
echo "
{
  \"pagesRepository\": \"https://github.com/tldr-pages/tldr\",
  \"repositoryBase\": \"https://tldr.sh/assets/tldr-pages\",
  \"skipUpdateWhenPageNotFound\": false,
  \"themes\": {
    \"ocean\": {
      \"commandName\": \"bold, cyan\",
      \"mainDescription\": \"\",
      \"exampleDescription\": \"green\",
      \"exampleCode\": \"cyan\",
      \"exampleToken\": \"dim\"
    }
  },
  \"theme\": \"ocean\"
}
" >>$HOME/.tldrrc

# ble.sh
curl -L https://github.com/akinomyoga/ble.sh/releases/download/nightly/ble-nightly.tar.xz | tar xJf -
bash ble-nightly/ble.sh --install ~/.local/share
echo 'source ~/.local/share/blesh/ble.sh' >>~/.bashrc

# lazyvim
git clone https://github.com/Jeswin-8801/My-Neovim-Config $HOME/.config/nvim
rm -rf $HOME/.config/nvim/.git

# --------------------------------------------------------------------------------------

# ssh-keygen -A
# https://www.ssh.com/academy/ssh/sshd#startup-and-roles-of-different-sshd-processes
ssh-keygen -t rsa -b 4096 -f $HOME/.ssh/ssh_host_rsa_key -N ""

# Port 2200

echo "HostKey $HOME/.ssh/ssh_host_rsa_key

LogLevel INFO
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
