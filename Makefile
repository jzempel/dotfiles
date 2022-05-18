.PHONY: ack bash brew git vim zsh

install: macos ack zsh bash git vim

all: brew install node

ack:
	rm -f ~/.ackrc
	ln -s `pwd`/ack/ackrc ~/.ackrc

brew:
	which brew || ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	brew update
	brew reinstall --cask kap
	brew reinstall --cask qlmarkdown
	brew reinstall --cask visual-studio-code
	brew reinstall ack
	brew reinstall bash-completion
	brew reinstall findutils
	brew reinstall fop
	brew reinstall git
	brew reinstall git-extras
	brew reinstall hub
	brew reinstall macvim
	brew reinstall node
	brew reinstall nvm
	brew reinstall python
	brew reinstall rbenv
	brew reinstall rename
	brew reinstall vcprompt
	brew reinstall watchman
	brew reinstall yarn
	brew upgrade
	brew cleanup

bash:
	rm -f ~/.bashrc ~/.inputrc
	ln -s `pwd`/bash/bashrc ~/.bashrc
	ln -s `pwd`/bash/inputrc ~/.inputrc
	cat `pwd`/bash/paths | sudo tee /etc/paths
	test -f ~/.bash_profile || ln -s `pwd`/bash/bash_profile ~/.bash_profile

git:
	mkdir -p ~/.config/git
	rm -f ~/.config/git/config ~/.gitignore
	ln -s `pwd`/git/gitconfig ~/.config/git/config
	ln -s `pwd`/git/gitignore ~/.gitignore

node:
	which node || brew install node
	npm install -g npm

macos:
	sudo grep -q "$$USER" /etc/sudoers || echo "$$USER	ALL=(ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers
	sudo scutil --set ComputerName "$$USER"
	sudo scutil --set HostName "$$USER"
	defaults write com.apple.menuextra.battery ShowPercent -string "NO"
	defaults write com.apple.menuextra.clock DateFormat -string "EEE MMM d  h:mm a"
	defaults write com.apple.systemuiserver menuExtras -array \
		"/Applications/Utilities/Keychain Access.app/Contents/Resources/Keychain.menu" \
		"/System/Library/CoreServices/Menu Extras/Bluetooth.menu" \
		"/System/Library/CoreServices/Menu Extras/AirPort.menu" \
		"/System/Library/CoreServices/Menu Extras/Volume.menu" \
		"/System/Library/CoreServices/Menu Extras/Battery.menu" \
		"/System/Library/CoreServices/Menu Extras/Clock.menu"
	defaults write NSGlobalDomain AppleInterfaceStyle -string Dark
	defaults write NSGlobalDomain AppleShowScrollBars -string Automatic
	defaults write NSGlobalDomain AppleAquaColorVariant -int 6
	defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
	sudo defaults write /Library/Preferences/.GlobalPreferences MultipleSessionEnabled -bool false
	sudo defaults write /Library/Preferences/com.apple.loginwindow GuestEnabled -bool false
	killall SystemUIServer
	defaults write com.apple.dock largesize -float 64.0
	defaults write com.apple.dock magnification -bool true
	defaults write com.apple.dock show-recents -bool false
	defaults write com.apple.dock tilesize -int 32
	killall Dock
	defaults write com.apple.finder DownloadsFolderListViewSettingsVersion -int 1
	defaults write com.apple.finder FXPreferredViewStyle clmv
	defaults write com.apple.finder NewWindowTarget PfHm
	defaults write com.apple.finder NewWindowTargetPath -string ~
	defaults write com.apple.finder QLEnableTextSelection -bool true
	killall Finder
	defaults write com.apple.itunes dontAutomaticallySyncIPods -bool true
	defaults write com.apple.safari HomePage -string https://www.google.com/
	defaults write com.apple.safari IncludeDevelopMenu -bool true
	defaults write com.apple.safari NewTabBehavior -int 0
	defaults write com.apple.safari NewWindowBehavior -int 0
	defaults write com.apple.screencapture location -string ~/Downloads
	defaults write com.apple.smb.server NetBIOSName -string $USER
	defaults write com.apple.terminal AutoMarkPromptLines -int 0
	defaults write com.apple.terminal "Default Window Settings" -string Pro
	defaults write com.apple.terminal "Startup Window Settings" -string Pro
	defaults write com.google.chrome AppleEnableSwipeNavigateWithScrolls -bool false
	killall cfprefsd
	sudo rm -f /Library/Caches/com.apple.desktop.admin.png
	sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist

python:
	pip3 install -U flake8
	pip3 install -U pytz
	pip3 install -U setuptools
	pip3 install -U virtualenvwrapper
	pip3 install -U yolk

ruby:
	sudo gem install -u bundler

vim:
	git submodule init
	git submodule update --remote --merge
	test -d ~/.vim || git clone https://github.com/carlhuda/janus.git ~/.vim
	cd ~/.vim && rake
	rm -rf ~/.janus ~/.vimrc.after
	ln -s `pwd`/vim/janus ~/.janus
	ln -s `pwd`/vim/vimrc ~/.vimrc.after
	defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false

zsh:
	test -d ~/.oh-my-zsh || sh -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	rm -f ~/.zshrc*
	ln -s `pwd`/zsh/zshrc ~/.zshrc
