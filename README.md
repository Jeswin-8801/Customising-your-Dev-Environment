# Customising-your-Remote-Dev-Setup

A simple beginner-friendly setup for a modern terminal and Vim editor for remote development through SSH.

The lack of color or graphics with endless lines of plain text is not an ideal development environment but it can be customised with endless variations to make it look and feel like one.

Here, I have set up a docker container with SSH enabled for a remote development environment for web dev.

# Get it Running

- Have Docker set up.
- After cloning, `cd into \Docker` and execute the following commands
- `docker build -t remote-dev .`
- `docker run --name remote-dev-env1 -p 2200:22 -it -d remote-dev`

Your docker container should be up and running

SSH into the container

- `ssh jeswins-dev@127.0.0.1 -p 2200`

_**NOTE:** change the username and password in Dockerfile to the one you prefer_

_In case you get the following error_

```
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
```

_run_

- `ssh-keygen -f "/home/jeswins/.ssh/known_hosts" -R "[127.0.0.1]:2200"`

## 🚀🚀🚀

![image](https://github.com/Jeswin-8801/Customising-your-Dev-Environment/assets/169489768/988716bd-3037-4f6c-8b6a-f384170f6a3e)

## Lazyvim 🔥🔥

![image](https://github.com/Jeswin-8801/Customising-your-Remote-Dev-Environment/assets/169489768/07ffd722-67e2-492f-a7bc-815447b12f02)

# Want the same customisation for your local terminal?

- run the script /terminal/setup.sh in WSL or a Linux system.

`NOTE: In case you are running this in WSL, install the nerd fonts separately.`

```shell
chmod +x setup.sh
./setup.sh
```
