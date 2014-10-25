#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

# dotfiles backup directory
dir=~/.dotfiles
# list of files/folders to symlink in homedir
files=".gemrc .gitmodules .gvimrc .vimrc .vim .vimbackup .zlogin .zshrc .zsh"
# Current timestamp for dotfile backup
timestamp=$(date "+%Y%m%d-%H%M%S")

##########

# initializing and update submodules
git submodule init && git submodule update

# create .dotfiles folder in homedir
echo "Creating $dir for backup of any existing dotfiles in ~"
mkdir -p $dir
mkdir -p $dir/$timestamp
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
echo "Backup any existing dotfiles from ~ to $dir/$timestamp"
for file in $files; do
    mv -f ~/$file $dir/$timestamp
    echo "Copy $file to home directory."
    cp -rf $dir/$file ~/$file
done
