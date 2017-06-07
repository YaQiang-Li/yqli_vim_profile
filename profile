# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi
PATH="$PATH:~/9-scripts:~/2-lib_project/makerulers:~/var/www/arcanist/devenv/arcanist/bin:~/var/www/arcanist/devenv/arcanist/scripts:~/bin/devenv/scripts"

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:/opt/armlite/bin:$PATH"
fi
if [ -d "$HOME/bin/bin" ] ; then
   PATH="$HOME/bin/bin:$PATH"
fi

TERM=linux

source ~/9-scripts/godir.sh

export CROSS_COMPILE=/opt/arm-hisiv300-linux/bin/arm-hisiv300-linux-uclibcgnueabi-
export ARCH=arm
