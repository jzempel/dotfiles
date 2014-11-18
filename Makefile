install: install-ack install-bash install-git install-vim

install-ack:
	rm -f ~/.ackrc
	ln -s `pwd`/ack/ackrc ~/.ackrc

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

install-osx:
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
	killall Finder
	defaults write com.apple.safari HomePage -string https://www.google.com/
	defaults write com.apple.safari NewTabBehavior -int 0
	defaults write com.apple.safari NewWindowBehavior -int 0
	defaults write com.apple.screencapture location -string ~/Downloads
	defaults write com.apple.terminal "Default Window Settings" -string Pro
	defaults write com.apple.terminal "Startup Window Settings" -string Pro
	killall cfprefsd
	defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
	sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist

install-python:
	@pip &> /dev/null || sudo easy_install -U pip
	sudo pip install -U flake8
	sudo pip install -U pip
	sudo pip install -U setuptools
	sudo pip install -U virtualenvwrapper
	sudo pip install -U yolk

install-vim:
	git submodule init
	git submodule update
	git submodule foreach git pull origin master
	test -d ~/.vim || git clone https://github.com/carlhuda/janus.git ~/.vim
	rm -rf ~/.janus ~/.vimrc.after
	ln -s `pwd`/vim/janus ~/.janus
	ln -s `pwd`/vim/vimrc ~/.vimrc.after
