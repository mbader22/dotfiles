#!/usr/bin/zsh

source ~/dotfiles/makesymlinks.sh
makesymlinks
fc-cache  # font cache aktualisieren
if [ $? = 0 ] ; then
  echo  "software installieren/deinstallieren (j/N)?"
  read -k 1 response

  if [ "$response" = "j" ]; then

    pacaur -S --needed --noedit --noconfirm vim-nerdtree vim-ctrlp vim-airline vim-airline-themes zsh vim-wombat oh-my-zsh-git

    pacaur -S --needed --noedit --noconfirm gimp inkscape google-chrome thunderbird xfce4-whiskermenu-plugin xfce4-volumed octave libreoffice-still libreoffice-still-de pdfshuffler-git simple-scan gutenprint audacious meld gtk-theme-arc numix-circle-icon-theme-git evince-no-gnome grive mediathek vlc mplayer gparted lightdm-gtk-greeter lightdm-gtk-greeter-settings

    pacaur -R pidgin
  fi
else
  echo "konnte Symlinks nicht erzeugen!"
fi
