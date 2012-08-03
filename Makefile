install: install-bash install-git install-vim

install-bash:
	rm -f ~/.bashrc ~/.inputrc
	ln -s `pwd`/bash/bashrc ~/.bashrc
	ln -s `pwd`/bash/inputrc ~/.inputrc
	test -d ~/.bash_profile || ln -s `pwd`/bash/bash_profile ~/.bash_profile

install-git:
	rm -f ~/.gitconfig ~/.gitignore
	ln -s `pwd`/git/gitconfig ~/.gitconfig
	ln -s `pwd`/git/gitignore ~/.gitignore

install-vim:
	git submodule init
	git submodule update
	test -d ~/.vim || git clone https://github.com/carlhuda/janus.git ~/.vim
	rm -rf ~/.janus ~/.vimrc.after
	ln -s `pwd`/vim/janus ~/.janus
	ln -s `pwd`/vim/vimrc ~/.vimrc.after
