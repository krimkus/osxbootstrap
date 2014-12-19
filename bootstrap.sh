#!/bin/bash

# Make this script execution path-independent
export DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

args=()
until [ -z "$1" ]; do
  case "$1" in
    -s|--ssd) SSD=true; shift;;
    -b|--battery) BATTERY=true; shift;;
    *) break ;;
  esac
done

successfully() {
  $* || (echo "failed" 1>&2 && exit 1)
}

# Check that Xcode command line tools are already there
clang_path=`which clang`
if [[ ! -f $clang_path ]]
then
	echo -ne "\x1B[00;31mYou need XCode command line tools to proceed\n\x1B[00m"
	exit -1
fi


################################################################[ GIT ]#########
echo "1st things 1st... (preconf based on https://github.com/thoughtbot/laptop)"
$DOTFILES_DIR/git/git.sh


################################################################[ Basic SW ]####
echo "Installing software... (thanks to Homebrew)"
$DOTFILES_DIR/brew/brew.sh
$DOTFILES_DIR/brew/linkbrew.sh


################################################################[ OSX ]#########
echo "Customizing OSX... (thanks much to https://github.com/Wilto/dotfiles)"
if [[ $BATTERY ]]
then
  $DOTFILES_DIR/config/osx.sh --battery
else
  $DOTFILES_DIR/config/osx.sh
fi


################################################################[ OSX ]#########
echo "Adding a local Dev folder and adding a default requirements_local.txt file to it."

mkdir ~/Dev
mv $DOTFILES_DIR/config/requirements_local.txt ~/Dev/requirements_local.txt


################################################################[ Flash drive settings ]##
if [[ $SSD ]]
then
  echo "Setting RootFS to mount with 'noatime'..."
  successfully sh $DOTFILES_DIR/config/AlwaysMountRootFSWithNoatime_MacOSX.sh
fi


################################################################[ ZSH customizations ]##
echo "Adding some general customizations to zsh..."
successfully ln -s $DOTFILES_DIR/config/general.zsh ~/.oh-my-zsh/custom/general.zsh
echo "(i) Use ~/.localrc for private customizations"


################################################################[ Dock Links ]##
echo "Run Dropbox to configure its folder..."
successfully open /Applications/Dropbox.app


################################################################[ Services ]####
echo "Add service+shortcut to..."
if [[ ! -d ~/Library/Services/ ]]
then
  mkdir -p ~/Library/Services/
fi
echo "...copy File or Directory path from Finder (Ctrl + Opt + Cmd + C)"
cp -r $DOTFILES_DIR/config/copyFilePath.workflow ~/Library/Services/copyFilePath.workflow 
defaults write pbs NSServicesStatus -dict-add '"(null) - copy file path - runWorkflowAsService"' '{ "key_equivalent" = "@^~c"; }'


################################################################[ The End ]#####
echo "DONE!"
echo "Remember that some stuff may only be operative after reboot (or simple user log out)"
echo "Take a look at Reminders.app to see what to do next (will open automatically)"
  
automator -i "Register Bartender" $DOTFILES_DIR/util/reminder.workflow
automator -i "Register DaisyDisk" $DOTFILES_DIR/util/reminder.workflow
automator -i "Review all other app/sw licenses!" $DOTFILES_DIR/util/reminder.workflow
automator -i "Cleanup all unwanted brew/cask app aliases in /Applications" $DOTFILES_DIR/util/reminder.workflow
automator -i "Install apps purchased on the Mac AppStore" $DOTFILES_DIR/util/reminder.workflow
open "/Applications/Reminders.app"

echo -e "\n\x1B[00;33m Special thanks to fbeeper and \x1B[00;34m https://github.com/fbeeper/fBootstrap \x1B[00m"
echo -e "\x1B[00;33m All comments, ideas, or code will be appreciated! \x1B[00m \n"
