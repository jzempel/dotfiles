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

install-vim:
	git submodule init
	git submodule update
	git submodule foreach git pull origin master
	test -d ~/.vim || git clone https://github.com/carlhuda/janus.git ~/.vim
	rm -rf ~/.janus ~/.vimrc.after
	ln -s `pwd`/vim/janus ~/.janus
	ln -s `pwd`/vim/vimrc ~/.vimrc.after
