FROM ubuntu:24.04

LABEL maintainer="Jeswin Santosh jeswin.santosh@outlook.com"

ARG user=jeswins-dev
ARG password=jeswins
ENV HOME /home/${user}

# Update the package list, install sudo, create a non-root user

RUN apt-get update && \
  apt-get install -y \
  build-essential \
  vim git sudo \
  wget curl hstr fd-find fzf bat python3-pip \
  openssh-server

# for delta
RUN apt-get install -y libreadline-dev pkg-config

RUN adduser --disabled-password $user && \
  echo "$user:$password" | chpasswd

# https://wiki.alpinelinux.org/wiki/Setting_up_a_new_user

RUN mkdir -p $HOME/.ssh/log && \
  cp -r /etc/ssh/sshd_config $HOME/.ssh && \
  chmod 644 $HOME/.ssh/sshd_config && \
  chown -R $user $HOME/.ssh

# ----------------------------------------------------------------------------------------------------------------

SHELL ["/bin/bash", "-c"]

# lsd
RUN mkdir -p ~/temp && \
  wget -q https://github.com/lsd-rs/lsd/releases/download/v1.1.2/lsd-musl_1.1.2_amd64.deb -O ~/temp/lsd.deb -S && \
  dpkg -i ~/temp/lsd.deb

# nnn
RUN git clone https://github.com/jarun/nnn.git /opt/nnn && \
  rm -rf /opt/nnn/.git && \
  make --directory /opt/nnn O_EMOJI=1 && \
  ln -s /opt/nnn/nnn /usr/local/bin/nnn && \
  export NNN_PLUG='f:finder;o:fzopen;p:mocq;d:diffs;t:nmount;v:imgview' && \
  export NNN_COLORS='#0a1b2c3d;1234'

# neovim
RUN wget -q https://github.com/neovim/neovim/releases/download/v0.10.0/nvim-linux64.tar.gz -O ~/temp/nvim.tar.gz -S && \
  tar -xzf ~/temp/nvim.tar.gz -C /opt/ && \
  ln -s /opt/nvim-linux64/bin/nvim /usr/local/bin/nvim

# lazygit
RUN wget -q https://github.com/jesseduffield/lazygit/releases/download/v0.42.0/lazygit_0.42.0_Darwin_arm64.tar.gz -O ~/temp/lazygit.tar.gz -S && \
  mkdir /opt/lazygit && \
  tar -xzf ~/temp/lazygit.tar.gz -C /opt/lazygit && \
  ln -s /opt/lazygit/lazygit /usr/local/bin/lazygit

# delta
RUN wget -q https://github.com/dandavison/delta/releases/download/0.17.0/git-delta_0.17.0_amd64.deb -O ~/temp/delta.deb && \
  dpkg -i ~/temp/delta.deb

# glow
RUN mkdir -p /etc/apt/keyrings && \
  curl -fsSL https://repo.charm.sh/apt/gpg.key | gpg --dearmor -o /etc/apt/keyrings/charm.gpg && \
  echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | tee /etc/apt/sources.list.d/charm.list && \
  apt-get update && apt-get -y install glow

SHELL ["/bin/sh", "-c"]

# check https://devhints.io/ for cheatsheets

# ----------------------------------------------------------------------------------------------------------------

RUN touch /run/motd.dynamic.new && \
  chown $user /run/motd.dynamic.new && \
  printf "%s\n%s\n" "cat /run/motd.dynamic.new" "service --status-all" >> /etc/profile

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

# in case you get a permission denied error RUN => sudo usermod -aG docker $USER
# to install packages using apt after the container is set up, run it as root using the command => docker exec -u root -t -i container_id /bin/bash

# set the current user
USER $user

# Set the working directory
WORKDIR ${HOME}
