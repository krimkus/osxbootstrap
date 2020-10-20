#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

successfully() {
  $* || (echo "failed" 1>&2 && exit 1)
}

################################################################[ BREW ]########
brew_path=`which brew`
if [[ ! -f $brew_path ]]
then
  echo "Installing Homebrew, a good OS X package manager..."
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "Putting Homebrew location earlier in PATH..." # similar to https://github.com/thoughtbot/laptop/blob/master/mac)
  successfully echo "export PATH='/usr/local/bin:\$PATH'" >> ~/.zshrc
  export PATH=/usr/local/bin:$PATH #temporary on bash

echo "Upda-grading Homebrew..."
  successfully brew update
  successfully brew upgrade

################################################################[ SW inst ]#####
echo "Hipsterizing your terminal with homebrewed zsh + Oh my zsh!"
  successfully brew install zsh
  successfully curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh

echo "Installing homebrew-cask... (easy .app install automation)"
  successfully brew tap phinze/homebrew-cask
  successfully brew install brew-cask
  successfully mkdir -p /usr/local/Library/Taps/my-casks/
  successfully ln -s $SCRIPT_DIR/Casks /usr/local/Library/Taps/my-casks/Casks

echo "Updating some tools..."
  brew install git
  brew install unrar

  brew tap mas-cli/tap
  brew tap-pin mas-cli/tap
  brew install mas

echo "Installing essential software..."
  #export HOMEBREW_CASK_OPTS="--appdir=/Applications"
  brew cask install bartender
  brew cask install bettertouchtool
  brew cask install caffeine
  brew cask install coconutbattery
  brew cask install daisydisk
  brew cask install firefox
  brew cask install google-chrome
  brew cask install omnifocus
  brew cask install postbox
  brew cask install spotify
  brew cask install the-unarchiver
  brew cask install vlc

echo "Installing dev tools..."
  brew cask install nova
  brew cask install fork
  brew cask install pyenv
  brew cask install iterm2
  brew install postgresql
  brew cask install notion
  brew install readline
  brew cask install visual-studio-code

echo "Signing into the App Store..."
  mas signin --dialog

echo "Installing apps from the App Store..."
  mas lucky 1Password
  mas lucky Acorn
  mas lucky "Fantastical 3"
  mas lucky Paprika
  mas lucky "Reeder 3"
  mas lucky Sketch
  mas lucky Slack
  mas lucky Transmit
  mas lucky Xcode
  mas lucky "Pixelmator Pro"

## An example of an app that needs to be manually installed
# echo "Downloading MacTex package for you (manual install!)..."
#   curl -OL http://mirror.ctan.org/systems/mac/mactex/MacTeX.pkg > ~/Downloads/MacTeX.pkg
#   # assuming its future installation... :P
#   echo "export PATH=\$PATH:/usr/texbin" >> ~/.zshrc
