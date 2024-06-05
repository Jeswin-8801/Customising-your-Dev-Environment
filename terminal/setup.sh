#!/bin/bash

sudo apt update
sudo apt autoremove

mkdir -p ~/temp

# lsd
wget https://github.com/lsd-rs/lsd/releases/download/v1.1.2/lsd-musl_1.1.2_amd64.deb -O ~/temp/lsd.deb -S
sudo apt install -y ~/temp/lsd.deb

# intsall other packages
sudo apt install -y hstr bat python3-pip libreadline-dev pkg-config unzip

# nnn
sudo git clone https://github.com/jarun/nnn.git /opt/nnn
sudo rm -rf /opt/nnn/.git
sudo make --directory /opt/nnn O_EMOJI=1
sudo ln -s /opt/nnn/nnn /usr/local/bin/nnn
export NNN_PLUG='f:finder;o:fzopen;p:mocq;d:diffs;t:nmount;v:imgview'
export NNN_COLORS='#0a1b2c3d;1234'

# delta
wget -q https://github.com/dandavison/delta/releases/download/0.17.0/git-delta_0.17.0_amd64.deb -O ~/temp/delta.deb
dpkg -i ~/temp/delta.deb

# oh my posh
sudo curl -s https://ohmyposh.dev/install.sh | sudo bash -s
mkdir -p ~/.fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip -O ~/temp/JetBrainsMono.zip -S
unzip -f ~/temp/JetBrainsMono.zip -d ~/.fonts
fc-cache -fv
wget https://raw.githubusercontent.com/Jeswin-8801/Customising-your-Remote-Dev-Environment/main/terminal/tokyonight_storm.omp.json -P ~/ohmyposh

# neovim
wget https://github.com/neovim/neovim/releases/download/v0.9.5/nvim-linux64.tar.gz -O ~/temp/nvim.tar.gz -S
sudo tar -xvzf ~/temp/nvim.tar.gz -C /opt/
sudo ln -s /opt/nvim-linux64/bin/nvim /usr/local/bin/nvim

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
" >>~/.bash_aliases

echo "
# OhMyPosh Theme
eval \"\$(oh-my-posh init bash --config ~/ohmyposh/tokyonight_storm.omp.json)\"

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
" >>~/.bashrc

echo "
[user]
    email = jeswin.santosh@outlook.com
    name = Jeswin-8801

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
" >>~/.gitconfig

touch ~/.tldrrc
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
" >>~/.tldrrc

# ble.sh
curl -L https://github.com/akinomyoga/ble.sh/releases/download/nightly/ble-nightly.tar.xz | tar xJf -
bash ble-nightly/ble.sh --install ~/.local/share
echo 'source ~/.local/share/blesh/ble.sh' >>~/.bashrc

mkdir -p ~/.config/lazygit && touch ~/.config/lazygit/config.yml
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
" >>~/.config/lazygit/config.yml

# lazygit
wget https://github.com/jesseduffield/lazygit/releases/download/v0.42.0/lazygit_0.42.0_Linux_x86_64.tar.gz -O ~/temp/lazygit.tar.gz -S
sudo mkdir /opt/lazygit
sudo tar -xvzf ~/temp/lazygit.tar.gz -C /opt/lazygit
sudo ln -s /opt/lazygit/lazygit /usr/local/bin/lazygit

rm -rf ~/temp

# lazyvim
git clone https://github.com/Jeswin-8801/My-Neovim-Config ~/.config/nvim
