#!/bin/zsh
############################
# makesymlinks.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
files=('zsh/aliases.zsh' 'zsh/functions.zsh' 'bashrc' 'vimrc' 'zshrc' 'config/Thunar/uca.xml' 'dircolors' 'config/xfce4/terminal/terminalrc')    # list of files/folders to symlink in homedir
folders=('gimp-2.8/scripts')
##########

# create dotfiles_old in homedir
olddir=~/dotfiles_old             # old dotfiles backup directory
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done\n"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done\n"

# create symlinks
for file in $files; do
  echo "Moving any existing dotfiles from ~ to $olddir"
  mv ~/.$file $olddir/
  echo "Creating symlink to $file in home directory."
  ln -s $dir/$file ~/.$file
done

# create symlinks
for folder in $folders; do
  if mkdir $olddir/${folder%/*} | grep 'kein Verzeichnis'
  then
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$folder/ $olddir/$folder
  fi
  echo "Creating symlink to $folder in home directory."
  ln -s -r $dir/$folder/ ~/.${folder%/*}/
done

echo "...done\n"
