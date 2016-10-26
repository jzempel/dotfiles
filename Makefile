install: install-osx install-ack install-bash install-git install-vim

install-ack:
	rm -f ~/.ackrc
	ln -s `pwd`/ack/ackrc ~/.ackrc

install-brew:
	which brew || ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	brew update
	brew reinstall ack
	brew reinstall bash-completion
	brew reinstall findutils
	brew reinstall fop
	brew reinstall git
	brew reinstall git-extras
	brew reinstall hardlink-osx
	brew reinstall hub
	brew reinstall macvim
	brew reinstall node
	brew reinstall rename
	brew reinstall vcprompt
	brew reinstall watchman
	brew tap jzempel/formula && brew reinstall continuity
	brew cleanup

install-bash:
	rm -f ~/.bashrc ~/.inputrc
	ln -s `pwd`/bash/bashrc ~/.bashrc
	ln -s `pwd`/bash/inputrc ~/.inputrc
	cat `pwd`/bash/paths | sudo tee /etc/paths
	test ~/.bash_profile || ln -s `pwd`/bash/bash_profile ~/.bash_profile

install-git:
	mkdir -p ~/.config/git
	rm -f ~/.config/git/config ~/.gitignore
	ln -s `pwd`/git/gitconfig ~/.config/git/config
	ln -s `pwd`/git/gitignore ~/.gitignore

install-node:
	which node || brew install node
	npm install -g npm

install-osx:
	echo "$$USER	ALL=(ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers
	defaults write com.apple.systemuiserver menuExtras -array \
		"/Applications/Utilities/Keychain Access.app/Contents/Resources/Keychain.menu" \
		"/System/Library/CoreServices/Menu Extras/Bluetooth.menu" \
		"/System/Library/CoreServices/Menu Extras/AirPort.menu" \
		"/System/Library/CoreServices/Menu Extras/Volume.menu" \
		"/System/Library/CoreServices/Menu Extras/Battery.menu" \
		"/System/Library/CoreServices/Menu Extras/Clock.menu"
	defaults write -g AppleShowScrollBars -string Automatic
	defaults write NSGlobalDomain AppleAquaColorVariant -int 6
	sudo defaults write /Library/Preferences/.GlobalPreferences MultipleSessionEnabled -bool false
	killall SystemUIServer
	defaults write com.apple.dock largesize -float 64.0
	defaults write com.apple.dock magnification -bool true
	defaults write com.apple.dock tilesize -int 32
	killall Dock
	defaults write com.apple.finder FXPreferredViewStyle clmv
	defaults write com.apple.finder NewWindowTarget PfHm
	defaults write com.apple.finder NewWindowTargetPath -string ~
	defaults write com.apple.finder QLEnableTextSelection -bool true
	defaults write com.apple.menuextra.clock DateFormat -string "EEE MMM d  h:mm a"
	killall Finder
	defaults write com.apple.safari HomePage -string https://www.google.com/
	defaults write com.apple.safari IncludeDevelopMenu -bool true
	defaults write com.apple.safari NewTabBehavior -int 0
	defaults write com.apple.safari NewWindowBehavior -int 0
	defaults write com.apple.screencapture location -string ~/Downloads
	defaults write com.apple.smb.server NetBIOSName -string $USER
	defaults write com.apple.terminal AutoMarkPromptLines -int 0
	defaults write com.apple.terminal "Default Window Settings" -string Pro
	defaults write com.apple.terminal "Startup Window Settings" -string Pro
	killall cfprefsd
	defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
	sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist

install-python:
	which pip || easy_install --user -U pip
	pip install --user -U flake8
	pip install --user -U pip
	pip install --user -U pytz
	pip install --user -U setuptools
	pip install --user -U virtualenvwrapper
	rm -f /usr/local/bin/virtualenv /usr/local/bin/virtualenvwrapper.sh
	ln -s ~/Library/Python/2.7/bin/virtualenv /usr/local/bin/virtualenv
	ln -s ~/Library/Python/2.7/bin/virtualenvwrapper.sh /usr/local/bin/virtualenvwrapper.sh
	pip install --user -U yolk

install-ruby:
	sudo gem install -u bundler
	sudo gem install -u scss_lint
	sudo gem install -u travis-lint
	which rvm || curl -sSL https://get.rvm.io | bash -s stable

install-vim:
	git submodule init
	git submodule update
	git submodule foreach git pull origin master
	test -d ~/.vim || git clone https://github.com/carlhuda/janus.git ~/.vim
	cd ~/.vim && rake
	rm -rf ~/.janus ~/.vimrc.after
	ln -s `pwd`/vim/janus ~/.janus
	ln -s `pwd`/vim/vimrc ~/.vimrc.after
