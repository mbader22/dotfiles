# dotfiles

My Linux setup.

##Installation1.

1. Clone this repository into your home folder

        git clone https://github.com/mbader22/dotfiles.git && cd ~/

1. Create ~/.bash folder

        mkdir ~/.bash

1. Symlink files

        ln -sf ~/dotfiles/bashrc ~/.bashrc
        ln -sf ~/dotfiles/aliases ~/.bash/aliases
        ln -sf ~/dotfiles/functions ~/.bash/functions
        ln -sf ~/dotfiles/vimrc ~/.vimrc
        ln -sf ~/dotfiles/Thunar/uca.xml ~/.config/Thunar/uca.xml
        ln -sf ~/dotfiles/dircolors/dircolors ~/.dircolors
        ln -sf ~/dotfiles/Terminal/terminalrc ~/.config/xfce4/terminal/terminalrc

##VIM

        pacaur -S vim-nerdtree vim-ctrlp vim-airline vim-airline-themes nerd-fonts-git
