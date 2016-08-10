#!/bin/zsh

~/dotfiles/makesymlinks.sh

pacaur -S --needed --noedit --noconfirm vim-nerdtree vim-ctrlp vim-airline vim-airline-themes nerd-fonts-git zsh vim-wombat oh-my-zsh-git

pacaur -S --needed --noedit --noconfirm gimp inkscape google-chrome thunderbird xfce4-whiskermenu-plugin xfce4-volumed octave libreoffice-still libreoffice-still-de pdfshuffler-git simple-scan gutenprint audacious meld gtk-theme-arc numix-circle-icon-theme-git evince-no-gnome grive mediathek vlc mplayer gparted lightdm-gtk-greeter lightdm-gtk-greeter-settings

pacaur -R pidgin
