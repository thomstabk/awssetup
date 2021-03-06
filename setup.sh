#!/bin/bash
# Simple setup.sh for configuring Ubuntu 12.04 LTS EC2 instance
# for headless setup. 

# Install nvm: node-version manager
# https://github.com/creationix/nvm
sudo apt-get install -y git-core
curl https://raw.github.com/creationix/nvm/master/install.sh | sh

# Load nvm and install latest production node
source $HOME/.nvm/nvm.sh
nvm install v0.10.12
nvm use v0.10.12

# Install jshint to allow checking of JS code within emacs
# http://jshint.com/
npm install -g jshint

# Install rlwrap to provide libreadline features with node
# See: http://nodejs.org/api/repl.html#repl_repl
sudo apt-get install -y rlwrap

# Install emacs24
# https://launchpad.net/~cassou/+archive/emacs
sudo apt-add-repository -y ppa:cassou/emacs
sudo apt-get update
sudo apt-get install -y emacs24 emacs24-el emacs24-common-non-dfsg

# git pull and install dotfiles as well
cd $HOME
if [ -d ./dotfiles/ ]; then
    mv dotfiles dotfiles.old
fi
if [ -d .emacs.d/ ]; then
    mv .emacs.d .emacs.d~
fi
git clone https://github.com/thomstabk/dotfiles.git
ln -sb dotfiles/.screenrc .
ln -sb dotfiles/.bash_profile .
ln -sb dotfiles/.bashrc .
ln -sb dotfiles/.bashrc_custom .
ln -sf dotfiles/.emacs.d .

#############################
# TG additions for own system

# Install LAMP Server
sudo apt-get install lamp-server^

# install ruby, gems and rails
#cd $HOME
#\curl -L https://get.rvm.io | bash -s stable --rails --ruby=1.9.3
#gem update

#install mysql
#sudo apt-get install mysql-client-core-5.5

#GEt R and R Studio
sudo apt-get update

dd if=/dev/zero of=/swapfile bs=1024 count=512k  #Setup memory swap files
mkswap /swapfile
swapon /swapfile

sudo apt-get install gdebi-core
sudo apt-get install libapparmor1 # Required only for Ubuntu, not Debian
wget http://download2.rstudio.org/rstudio-server-0.98.978-i386.deb
sudo gdebi rstudio-server-0.98.978-i386.deb


#install heroku toolbelt
wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh

#Configure GIT
git config --global color.ui true
git config -- global user.name "Thomstabk"
git config --global user.email tgoerner@gmail.com

# Load nvm and install latest production node
source $HOME/.nvm/nvm.sh
nvm use v0.10.12
npm install express

#flush cache
free -m
sync; echo 3 > /proc/sys/vm/drop_caches
