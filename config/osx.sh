#!/bin/bash
# inspired by Mathias Bynens: https://github.com/mathiasbynens/dotfiles

successfully() {
  $* || (echo "failed" 1>&2 && exit 1)
}

args=()
until [ -z "$1" ]; do
  case "$1" in
    -f|--flash) FLASH=true; shift;;
    -b|--battery) BATTERY=true; shift;;
    *) break ;;
  esac
done

echo "Root password needed to run OSX customization of settings:"
# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &


# System Name
# ----------------------------------------------------------------------

echo "Introduce a name for your machine: (eg. KyMac)"
successfully read SYSTEM_HOSTNAME

echo "Setting computer name..." # (as done via System Preferences -> Sharing)
sudo scutil --set ComputerName "$SYSTEM_HOSTNAME"
sudo scutil --set HostName "$SYSTEM_HOSTNAME"
sudo scutil --set LocalHostName "$SYSTEM_HOSTNAME"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$SYSTEM_HOSTNAME"


# Menu
# ----------------------------------------------------------------------

echo "Customizing misc OSX settins..."
# Clock
defaults write com.apple.menuextra.clock DateFormat -string "EEE HH:mm"
defaults write com.apple.menuextra.clock FlashDateSeparators -bool false
defaults write com.apple.menuextra.clock IsAnalog -bool false

if [[ $BATTERY ]]
then
  # Menu bar: show battery percentage
  defaults write com.apple.menuextra.battery ShowPercent -string "YES"
fi

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1


# Panels
# ----------------------------------------------------------------------

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true

# Disable the "Are you sure you want to open this application?" dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3


# Universal Access
# ----------------------------------------------------------------------

# Enable access for assistive devices
echo -n 'a' | sudo tee /private/var/db/.AccessibilityAPIEnabled > /dev/null 2>&1
sudo chmod 444 /private/var/db/.AccessibilityAPIEnabled

# Use scroll gesture with the Ctrl (^) modifier key to zoom
defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144

# Follow the keyboard focus while zoomed in
defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true

# Automatically illuminate built-in MacBook keyboard in low light
defaults write com.apple.BezelServices kDim -bool true

# Turn off keyboard illumination when computer is not used for 5 minutes
defaults write com.apple.BezelServices kDimTime -int 300


# Dock
# ----------------------------------------------------------------------

# Set the icon size of Dock items to 36 pixels
defaults write com.apple.dock tilesize -int 50

# Dock: don’t animate opening applications
defaults write com.apple.dock launchanim -bool false

# Not only open apps in Dock (i need to mantain it in order to have folder links)
defaults write com.apple.dock static-only -boolean false

# But delete all predefined app links
defaults delete com.apple.dock persistent-apps

# Predefined folders too... I will decide how I like them :P
defaults delete com.apple.dock persistent-others

# Simpler minimize effect
defaults write com.apple.dock mineffect -string scale

# Minimize to application (System Preferences → Dock)
defaults write com.apple.dock minimize-to-application -bool true

# Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.1

# Enable spring loading for all Dock items
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

# Don't show Dashboard as a Space
defaults write com.apple.dock dashboard-in-overlay -bool true

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Disable Dock magnification
defaults write com.apple.dock magnification -boolean false

# Disable dock hidding delay
defaults write com.apple.Dock autohide-delay -float 0

# Trackpad app exposé swipe down
defaults write com.apple.dock showAppExposeGestureEnabled -bool true

# Reset Launchpad
find ~/Library/Application\ Support/Dock -name "*.db" -maxdepth 1 -delete


# Finder
# ----------------------------------------------------------------------

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: show full path in title bar
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Finder: disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Finder: show the ~/Library folder (in OS X Lion)
chflags nohidden ~/Library

# Enable AirDrop over Ethernet and on unsupported Macs running Lion
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

# Open default on my home folder
defaults write com.apple.finder NewWindowTargetPath -string "file://localhost${HOME}"

# Increase window resize speed for Cocoa applications
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# Finder: use list view in all windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Hide icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false

# Enable snap-to-grid for desktop icons
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Finder: allow text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Disable disk image verification
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

# Automatically open a new Finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true


# Disks
# ----------------------------------------------------------------------

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Time Machine: Prevent Time Machine from prompting to use new hard drives as backup volume
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Time Machine: Disable Local Time Machine
hash tmutil &> /dev/null && sudo tmutil disablelocal


# Safari
# ----------------------------------------------------------------------

# Set Safari's home page to `about:blank` for faster loading
defaults write com.apple.Safari HomePage -string "about:blank"

# Prevent Safari from opening "safe" files automatically after downloading
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# Hide Safari's bookmarks bar by default
defaults write com.apple.Safari ShowFavoritesBar -bool false

# Disable Safari's thumbnail cache for History and Top Sites
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

# Remove useless icons from Safari's bookmarks bar
defaults write com.apple.Safari ProxiesInBookmarksBar "()"

# Enable the Develop menu and the Web Inspector in Safari
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true


# Misc
# ----------------------------------------------------------------------

# Terminal: Only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4

# iTunes: make ⌘ + F focus the search input
defaults write com.apple.iTunes NSUserKeyEquivalents -dict-add "Target Search Field" "@F"

# Spotlight: disable Dictionary results
defaults write com.apple.spotlight DictionaryLookupEnabled -bool false

# Adjust how long before display is put to sleep when plugged in
sudo pmset -a displaysleep 30
# Adjust how long before display is put to sleep when on battery
sudo pmset -b displaysleep 15


# Cleanup
# ----------------------------------------------------------------------

# Kill affected applications
for app in Finder Dock Safari SystemUIServer; do
	killall "$app" > /dev/null 2>&1
done

echo "Done. Note that some of these changes require a logout/restart to take effect."

