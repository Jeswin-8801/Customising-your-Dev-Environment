FROM ubuntu

LABEL maintainer="Jeswin Santosh jeswin.santosh@outlook.com"

ARG user=jeswins-dev
ARG password=jeswins
ENV HOME /home/${user}

# Update the package list, install sudo, create a non-root user
RUN apt-get update && \
    apt-get upgrade -y && \
    apt install -y tree vim wget git net-tools zip curl openssh-server && \
    adduser --disabled-password $user && \
    echo "$user:$password" | chpasswd

# https://wiki.alpinelinux.org/wiki/Setting_up_a_new_user

RUN mkdir -p $HOME/.ssh/log && \
    cp -r /etc/ssh/sshd_config $HOME/.ssh && \
    chmod 644 $HOME/.ssh/sshd_config && \
    chown -R $user $HOME/.ssh

# ----------------------------------------------------------------------------------------------------------------

RUN apt install -y build-essential

# lsd
RUN mkdir -p ~/temp && \
    wget https://github.com/lsd-rs/lsd/releases/download/v1.1.2/lsd-musl_1.1.2_amd64.deb -O ~/temp/lsd.deb -S && \
    apt install -y ~/temp/lsd.deb

# neovim
RUN wget https://github.com/neovim/neovim/releases/download/v0.9.5/nvim-linux64.tar.gz -O ~/temp/nvim.tar.gz -S && \
    tar -xzf ~/temp/nvim.tar.gz -C /opt/ && \
    ln -s /opt/nvim-linux64/bin/nvim /usr/local/bin/nvim && \
    rm -rf ~/temp

# ----------------------------------------------------------------------------------------------------------------

RUN touch /run/motd.dynamic.new && \
    chown $user /run/motd.dynamic.new && \
    echo "cat /run/motd.dynamic.new\nservice --status-all" >> /etc/profile

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

# in case you get a permission denied error RUN => sudo usermod -aG docker $USER

# set the current user
USER $user

# Set the working directory
WORKDIR ${HOME}
