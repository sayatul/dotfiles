#!/usr/bin/env bash

###########################
# This script installs the dotfiles and runs all other system configuration scripts
# @author Atul Yadav
###########################

#####
# install homebrew (CLI Packages)
#####

brew_bin=$(which brew) 2>&1 > /dev/null
if [[ $? != 0 ]]; then
  action "installing homebrew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    if [[ $? != 0 ]]; then
      error "unable to install homebrew, script $0 abort!"
      exit 2
  fi
else
  # Make sure we’re using the latest Homebrew
  brew update
  read -r -p "run brew upgrade? [y|N] " response
  if [[ $response =~ ^(y|yes|Y) ]];then
      # Upgrade any already-installed formulae
      brew upgrade
  fi
fi

#####
# install brew cask (UI Packages)
#####
output=$(brew tap | grep cask)
if [[ $? != 0 ]]; then
  brew install caskroom/cask/brew-cask
fi
brew tap caskroom/versions > /dev/null 2>&1

# install brew packages
sh brew.sh


# install vim vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# create symlinks & directories
mkdir ~/WorkSpace
mkdir ~/Envs

ln -sf ~/dotfiles/homedir/.zshrc ~/.zshrc
ln -sf ~/dotfiles/homedir/aliases.zsh ~/.oh-my-zsh/custom/aliases.zsh
ln -sf ~/dotfiles/homedir/.vim ~/.vim
ln -sf ~/dotfiles/homedir/.vimrc ~/.vimrc
ln -sf ~/dotfiles/homedir/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/homedir/.gitignore ~/.gitignore

#####
# set defaults for macos
#####


# iTerm2
# Specify the preferences directory
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/dotfiles/config/"
# Tell iTerm2 to use the custom preferences in the directory
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

# disable guest user
defaults write /Library/Preferences/com.apple.AppleFileServer guestAccess -bool NO
defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server AllowGuestAccess -bool NO
