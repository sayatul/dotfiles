#!/usr/bin/env bash

###########################
# This script installs the dotfiles and runs all other system configuration scripts
# @author Atul Yadav
###########################

# install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# install zsh
/bin/bash -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install brew packages
sh brew.sh

# create symlinks & directories
mkdir ~/WorkSpace
mkdir ~/Envs

ln -sf ~/dotfiles/homedir/.zshrc ~/.zshrc
ln -sf ~/dotfiles/homedir/aliases.zsh ~/.oh-my-zsh/custom/aliases.zsh
ln -sf ~/dotfiles/homedir/commands.zsh ~/.oh-my-zsh/custom/commands.zsh
ln -sf ~/dotfiles/homedir/.vim ~/.vim
ln -sf ~/dotfiles/homedir/.vimrc ~/.vimrc
ln -sf ~/dotfiles/homedir/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/homedir/.gitignore ~/.gitignore

# install vim vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# iTerm2
# Specify the preferences directory
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/dotfiles/config/"
# Tell iTerm2 to use the custom preferences in the directory
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

# disable guest user
# defaults write /Library/Preferences/com.apple.AppleFileServer guestAccess -bool NO
# defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server AllowGuestAccess -bool NO
