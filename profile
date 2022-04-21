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
PATH="$PATH:$HOME/9-scripts:~/2-lib_project/makerulers:~/var/www/arcanist/devenv/arcanist/bin:~/var/www/arcanist/devenv/arcanist/scripts:~/bin/devenv/scripts"

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:/opt/armlite/bin:$PATH"
fi
if [ -d "$HOME/bin/bin" ] ; then
   PATH="$HOME/bin/bin:$PATH"
fi

TERM=linux

source ~/9-scripts/godir.sh

#export CROSS_COMPILE=/opt/arm-hisiv300-linux/bin/arm-hisiv300-linux-uclibcgnueabi-
#export CROSS_COMPILE=/opt/gcc-linaro-6.5.0-2018.12-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-
#export CROSS_COMPILE=/opt/gcc-linaro-7.5.0-2019.12-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-
export CROSS_COMPILE=/opt/gcc-ubuntu-9.3.0-2020.03-x86_64-aarch64-linux-gnu/bin/aarch64-linux-gnu-
export LD_LIBRARY_PATH=/opt/gcc-ubuntu-9.3.0-2020.03-x86_64-aarch64-linux-gnu/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH
export ARCH=arm
PATH=$PATH:/home/glenn/bin/android-toolchain-r16b/bin/
export  JAVA_HOME=/usr/java/jdk1.6.0_45
export  CLASSPATH=.:$JAVA_HOME/jre/lib/rt.jar:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
export  PATH=$PATH:$JAVA_HOME/bin:/home/glenn/01-x2/02-hsp_sdk/gcc-linaro-6.5.0-2018.12-x86_64_aarch64-linux-gnu/bin
export  PATH=$PATH:/home/glenn/02_mini2451/opt/FriendlyARM/toolschain/4.4.3/bin/
#export  PATH=$PATH:/opt/gcc-linaro-6.5.0-2018.12-x86_64_aarch64-linux-gnu/bin/
export  PATH=$PATH:/opt/gcc-ubuntu-9.3.0-2020.03-x86_64-aarch64-linux-gnu/bin/
#export  PATH=$PATH:/home/glenn/.local/bin
#export LINARO_GCC_ROOT=/opt/gcc-linaro-6.5.0-2018.12-x86_64_aarch64-linux-gnu/

# activate conda env
source activate gluon
#source activate py27

#source "/home/glenn/1-work/4-x3/01-sdk/01-app_test/ffmpeg_webassembly/emsdk/emsdk_env.sh"
