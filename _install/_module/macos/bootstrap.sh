#!/usr/bin/env bash

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Settings" to quit'

# Ask for the administrator password upfront
sudo -

# /Library/KeyBindings/DefaultKeyBinding.dict
# {
#     "\UF729" = "moveToBeginningOfLine:";
#     "\UF72B"   = "moveToEndOfLine:";
#     "$\UF729" = moveToBeginningOfLineAndModifySelection:; // shift-home
#     "$\UF72B" = moveToEndOfLineAndModifySelection:; // shift-end
#     "^\UF729" = moveToBeginningOfDocument:; // ctrl-home
#     "^\UF72B" = moveToEndOfDocument:; // ctrl-end
#     "^$\UF729" = moveToBeginningOfDocumentAndModifySelection:; // ctrl-shift-home
#     "^$\UF72B" = moveToEndOfDocumentAndModifySelection:; // ctrl-shift-end
# }

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
# while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################
# General UI/UX                                                               #
###############################################################################

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Remove duplicates in the “Open With” menu (also see `lscleanup` alias)
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user

# Display ASCII control characters using caret notation in standard text views
# Try e.g. `cd /tmp; unidecode "\x{0000}" > cc.txt; open -e cc.txt`
defaults write NSGlobalDomain NSTextShowsControlCharacters -bool true

# Reveal IP address, hostname, OS version, etc. when clicking the clock
# in the login window
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# Disable automatic capitalization as it’s annoying when typing code
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable smart dashes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

###############################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input                 #
###############################################################################

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

###############################################################################
# Energy saving                                                               #
###############################################################################

# Sleep the display after 2 minutes
sudo pmset -a displaysleep 2

###############################################################################
# Screen                                                                      #
###############################################################################

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

# Save screenshots to the specified directory
defaults write com.apple.screencapture location -string "${HOME}/Pictures/Screenshots"

# Enable HiDPI display modes (requires restart)
# sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

###############################################################################
# Finder                                                                      #
###############################################################################

# Show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Finder: show hidden files by default
#defaults write com.apple.finder AppleShowAllFiles -bool true

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Enable AirDrop over Ethernet and on unsupported Macs running Lion
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

defaults write com.apple.finder FXInfoPanesExpanded -dict \
  General -bool true \
  OpenWith -bool true \
  Privileges -bool true

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `glyv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

###############################################################################
# Dock, Dashboard, and hot corners                                            #
###############################################################################

# Show indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool true

# Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 0

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Don’t show recent applications in Dock
defaults write com.apple.dock show-recents -bool false

###############################################################################
# Safari & WebKit                                                             #
###############################################################################

# Privacy: don’t send search queries to Apple
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# Show the full URL in the address bar (note: this still hides the scheme)
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# Prevent Safari from opening ‘safe’ files automatically after downloading
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

# Enable Safari’s debug menu
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# Enable the Develop menu and the Web Inspector in Safari
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# Add a context menu item for showing the Web Inspector in web views
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# Enable continuous spellchecking
defaults write com.apple.Safari WebContinuousSpellCheckingEnabled -bool true
# Disable auto-correct
defaults write com.apple.Safari WebAutomaticSpellingCorrectionEnabled -bool false

# Warn about fraudulent websites
defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true

# Enable “Do Not Track”
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true

# Update extensions automatically
defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool true

###############################################################################
# Terminal & iTerm 2                                                          #
###############################################################################

# Only use UTF-8 in Terminal.app
defaults write com.apple.terminal StringEncodings -array 4

# Disable the annoying line marks
defaults write com.apple.Terminal ShowLineMarks -int 0

###############################################################################
# Time Machine                                                                #
###############################################################################

# Prevent Time Machine from prompting to use new hard drives as backup volume
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Set default folder exclusions
# Fins all excluded folders:
# sudo mdfind "com_apple_backup_excludeItem = 'com.apple.backupd'
# Remove an exclusion:
# sudo tmutil removeexclusion /path/to/directory

sudo tmutil addexclusion -p "/private/tmp/"
sudo tmutil addexclusion -p "/private/var/db/diagnostics"
sudo tmutil addexclusion -p "/private/var/db/oah"
sudo tmutil addexclusion -p "/private/var/vm/sleepimage"
sudo tmutil addexclusion -p "/private/var/folders"
sudo tmutil addexclusion -p "/tmp"
sudo tmutil addexclusion -p "/nix/store"
sudo tmutil addexclusion -p "/nix/var"
sudo tmutil addexclusion -p "${HOME}/.dropbox"
sudo tmutil addexclusion -p "${HOME}/Dropbox"
sudo tmutil addexclusion -p "${HOME}/Google Drive/"
sudo tmutil addexclusion -p "${HOME}/.android"
sudo tmutil addexclusion -p "${HOME}/.asdf"
sudo tmutil addexclusion -p "${HOME}/.bundle"
sudo tmutil addexclusion -p "${HOME}/.cache"
sudo tmutil addexclusion -p "${HOME}/.cocoapods"
sudo tmutil addexclusion -p "${HOME}/.colima"
sudo tmutil addexclusion -p "${HOME}/.composer"
sudo tmutil addexclusion -p "${HOME}/.diffusionbee"
sudo tmutil addexclusion -p "${HOME}/.electron"
sudo tmutil addexclusion -p "${HOME}/.gradle"
sudo tmutil addexclusion -p "${HOME}/.gluon"
sudo tmutil addexclusion -p "${HOME}/.nuget"
sudo tmutil addexclusion -p "${HOME}/.ollama"
sudo tmutil addexclusion -p "${HOME}/.kerl"
sudo tmutil addexclusion -p "${HOME}/.local"
sudo tmutil addexclusion -p "${HOME}/.m2"
sudo tmutil addexclusion -p "${HOME}/.gem"
sudo tmutil addexclusion -p "${HOME}/.rubies"
sudo tmutil addexclusion -p "${HOME}/.rbenv"
sudo tmutil addexclusion -p "${HOME}/.gradle"
sudo tmutil addexclusion -p "${HOME}/.virtualenvs"
sudo tmutil addexclusion -p "${HOME}/.venv"
sudo tmutil addexclusion -p "${HOME}/.pyenv"
sudo tmutil addexclusion -p "${HOME}/.node-gyp/"
sudo tmutil addexclusion -p "${HOME}/.npm/"
sudo tmutil addexclusion -p "${HOME}/.nuget/"
sudo tmutil addexclusion -p "${HOME}/.lima/"
sudo tmutil addexclusion -p "${HOME}/.ollma/"
sudo tmutil addexclusion -p "${HOME}/.bun/"
sudo tmutil addexclusion -p "${HOME}/.nvm/"
sudo tmutil addexclusion -p "${HOME}/.yarn/"
sudo tmutil addexclusion -p "${HOME}/.replay/"
sudo tmutil addexclusion -p "${HOME}/.solargraph/"
sudo tmutil addexclusion -p "${HOME}/.sonar/cache/"
sudo tmutil addexclusion -p "${HOME}/.Trash/"
sudo tmutil addexclusion -p "${HOME}/.vagrant.d/"
sudo tmutil addexclusion -p "${HOME}/.vpython-root/"
sudo tmutil addexclusion -p "${HOME}/.vscode/"
sudo tmutil addexclusion -p "${HOME}/.vscode-insiders/"
sudo tmutil addexclusion -p "${HOME}/.go"
sudo tmutil addexclusion -p "${HOME}/go"
sudo tmutil addexclusion -p "${HOME}/vagrant.d"
sudo tmutil addexclusion -p "${HOME}/Library/Application Support/JetBrains"
sudo tmutil addexclusion -p "${HOME}/Library/Application Support/Steam/SteamApps"
sudo tmutil addexclusion -p "${HOME}/Library/Application Support/Caches"
sudo tmutil addexclusion -p "${HOME}/Library/Application Support/Code/Caches"
sudo tmutil addexclusion -p "${HOME}/Library/Application Support/Code/CachedData"
sudo tmutil addexclusion -p "${HOME}/Library/Application Support/Code/CachedExtensionVSIXs"
sudo tmutil addexclusion -p "${HOME}/Library/Application Support/Microsoft/Teams/Cache"
sudo tmutil addexclusion -p "${HOME}/Library/Application Support/Microsoft/Teams/Code Cache"
sudo tmutil addexclusion -p "${HOME}/Library/Application Support/Microsoft/Teams/Service Worker/CacheStorage"
sudo tmutil addexclusion -p "${HOME}/Library/Application Support/Signal/update-cache"
sudo tmutil addexclusion -p "${HOME}/Library/Application\ Support/PixelFlasher/"
sudo tmutil addexclusion -p "${HOME}/Library/Android"
sudo tmutil addexclusion -p "${HOME}/Library/Caches"
sudo tmutil addexclusion -p "${HOME}/Library/CloudStorage/"
sudo tmutil addexclusion -p "${HOME}/Library/Application Support/Google/Chrome/Default/Service Worker/CacheStorage"
sudo tmutil addexclusion -p "${HOME}/Library/Developer/CoreSimulator/Caches"
sudo tmutil addexclusion -p "${HOME}/Library/Developer/DeveloperDiskImages"
sudo tmutil addexclusion -p "${HOME}/Library/Containers/com.docker.docker"
sudo tmutil addexclusion -p "${HOME}/Library/Containers/com.netease.163music/Data/Caches"
sudo tmutil addexclusion -p "${HOME}/Library/Containers/com.microsoft.errorreporting"
sudo tmutil addexclusion -p "${HOME}/Library/Containers/com.tencent.xinWeChat/Data/Library/Caches"
sudo tmutil addexclusion -p "${HOME}/Library/Application Support/discord/Cache/"
sudo tmutil addexclusion -p "${HOME}/Library/Application Support/discord/DawnCache"
sudo tmutil addexclusion -p "${HOME}/Library/Application Support/discord/DawnGraphiteCache"
sudo tmutil addexclusion -p "${HOME}/Library/Application Support/discord/DawnWebGPUCache"
sudo tmutil addexclusion -p "${HOME}/Library/Application Support/discord/GPUCache"
sudo tmutil addexclusion -p "${HOME}/Library/Application Support/discord/modules.log"
sudo tmutil addexclusion -p "${HOME}/Library/Application Support/OpenMTP/Cache/"
sudo tmutil addexclusion -p "${HOME}/Library/pnpm"
sudo tmutil addexclusion -p "${HOME}/Library/Logs"
sudo tmutil addexclusion -p "${HOME}/Library/CloudStorage"

sudo tmutil addexclusion -p "${HOME}/FinalCutRaw"
sudo tmutil addexclusion -p "${HOME}/Music"
sudo tmutil addexclusion -p "${HOME}/Movies"
sudo tmutil addexclusion -p "/Applications/Install macOS Sonoma.app"
sudo tmutil addexclusion -p "/Applications/Install macOS Ventura.app"
sudo tmutil addexclusion -p "/Applications/Install macOS Monterey.app"
sudo tmutil addexclusion -p "/Applications/Install macOS Big Sur.app"
sudo tmutil addexclusion -p "/Applications/Install macOS Catalina.app"
sudo tmutil addexclusion -p "/Applications/Install macOS High Sierra.app"
sudo tmutil addexclusion -p "/Applications/Install macOS Mojave.app"
sudo tmutil addexclusion -p "/Applications/Install macOS Monterey.app"
sudo tmutil addexclusion -p "/Applications/Install macOS Sequoia.app"
sudo tmutil addexclusion -p "/Applications/Xcode.app"

sudo tmutil addexclusion -p "${HOME}/Project/"
sudo tmutil addexclusion -p "${HOME}/Works/"
sudo tmutil addexclusion -p "${HOME}/Tools/"
sudo tmutil addexclusion -p "${HOME}/Movies/Wondershare UniConverter/Downloaded"
sudo tmutil addexclusion -p "/tmp/"
sudo tmutil addexclusion -p "/nix/store/"
sudo tmutil addexclusion -p "/nix/var/"
sudo tmutil addexclusion -p "/System/Library/Caches/"
# necessary to ignore recursively checking the same directories again
sudo tmutil addexclusion -p "/System/Volumes/"

###############################################################################
# Activity Monitor                                                            #
###############################################################################

# Show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

# Visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5

###############################################################################
# Address Book, Dashboard, iCal, TextEdit, and Disk Utility                   #
###############################################################################

# Use plain text mode for new TextEdit documents
defaults write com.apple.TextEdit RichText -int 0
# Open and save files as UTF-8 in TextEdit
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

# Enable the debug menu in Disk Utility
defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
defaults write com.apple.DiskUtility advanced-image-options -bool true

###############################################################################
# Mac App Store                                                               #
###############################################################################

# Enable the WebKit Developer Tools in the Mac App Store
defaults write com.apple.appstore WebKitDeveloperExtras -bool true

# Enable Debug Menu in the Mac App Store
defaults write com.apple.appstore ShowDebugMenu -bool true

# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

###############################################################################
# Photos                                                                      #
###############################################################################

# Prevent Photos from opening automatically when devices are plugged in
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true
