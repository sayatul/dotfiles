# Install java first
brew cask install java

# Install other useful binaries.
echo "installing essential packages"
brew install ack
brew install git-lfs
brew install rename
brew install hub
brew install telnet
brew install youtube-dl
brew install heroku/brew/heroku

# Install brew cask packages
echo "installing cask packages"
brew cask install appcleaner
brew cask install iterm2
brew cask install macvim
brew cask install google-chrome
brew cask install sublime-text
brew cask install etcher
brew cask install teamviewer
brew cask install spectacle
brew cask install cyberduck
brew cask install slack
brew cask install applepi-baker
brew cask install android-file-transfer
brew cask install keka
brew cask install vlc
brew cask install folx

# Install GnuPG to enable PGP-signing commits.
brew cask install gnupg

# Install more recent versions of some macOS tools.
brew install grep
brew install openssh
