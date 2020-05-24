#!/bin/bash


# to maintain cask ....
#     brew update && brew upgrade brew-cask && brew cleanup && brew cask cleanup`


# Install native apps

# Error: caskroom/cask was moved. Tap homebrew/cask-cask instead.
brew install homebrew/cask-cask
# brew tap caskroom/versions

# daily
brew cask install rectangle
brew cask install gyazo
brew cask install bitwarden
brew cask install rescuetime
brew cask install slack
brew cask install skitch
brew cask install dash
# brew cask install flux

# dev
brew cask install iterm2
# brew cask install sublime-text
brew cask install visual-studio-code
brew cask install imagealpha
brew cask install imageoptim

# fun
# brew cask install limechat
# brew cask install miro-video-converter
# brew cask install horndis               # usb tethering

# browsers
# brew cask install google-chrome-canary
# brew cask install firefoxnightly
# brew cask install webkit-nightly
# brew cask install chromium
# brew cask install torbrowser

# less often
brew cask install disk-inventory-x
brew cask install screenflow
brew cask install vlc
brew cask install licecap

# brew cask install utorrent
# brew cask install spotify

brew tap homebrew/cask-fonts
# brew cask install font-fira-code

# Not on cask but I want regardless.
# Bear Notes

# Install Pastebot
# Install bear
# Install uc
# Install quip
# Install https://github.com/MacPass/MacPass/releases/tag/0.7.12
# Install chrome
# Install macpass
# Install brew /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

# Install amphetamine

# Install itau https://guardiao.itau.com.br/UpdateServer/aplicativoitau.dmg
