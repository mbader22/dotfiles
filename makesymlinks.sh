#!/bin/zsh


############################
# Name: makesymlinks.sh
# Brief: This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
# Author: cunda2@outlook.com
############################




########## Constants ##########
readonly MS_ERROR="[\e[31merror\e[0m"
readonly MS_INFO="[\e[32minfo  \e[0m"
readonly MS_MOVE="[\e[32mmove  \e[0m"
readonly MS_DELETE="[\e[32mdelete\e[0m"
readonly MS_CREATE="[\e[32mcreate\e[0m"
readonly MS_IDLE="[\e[32midle  \e[0m"
readonly MS_HIGHLIGHT="\e[97m"
readonly MS_DEFAULT="\e[0m"

readonly MS_ENDING='desktop'

readonly MS_DIR=~/dotfiles                    # dotfiles directory
readonly MS_FILES=('zsh/aliases.zsh' 'zsh/functions.zsh' 'bashrc' 'vimrc' 'zshrc' 'config/Thunar/uca.xml' 'dircolors' 'config/xfce4/terminal/terminalrc')    # list of files/folders to symlink in homedir
readonly MS_FOLDERS=('gimp-2.8/scripts' 'local/share/fonts' 'local/share/Thunar/sendto')

# create dotfiles_old in homedir
readonly MS_OLDDIR=~/dotfiles_old             # old dotfiles backup directory
###############################





if [[ ! -d $MS_OLDDIR ]] ; then
  if [[ ! -a $MS_OLDDIR ]] ; then
    echo "$MS_CREATE $MS_HIGHLIGHT$MS_OLDDIR$MS_DEFAULT] Creating for backup of any existing dotfiles in ~"
    mkdir -p $MS_OLDDIR
    echo "...done\n"
  else
    echo "$MS_ERROR $MS_HIGHLIGHT$MS_OLDDIR$MS_DEFAULT] $MS_HIGHLIGHT$MS_OLDDIR$MS_DEFAULT  already exists and is not an directory"
    echo "$MS_ERROR $MS_HIGHLIGHT$MS_OLDDIR$MS_DEFAULT] rename or remove file $MS_HIGHLIGHT$MS_OLDDIR$MS_DEFAULT before starting this symlink script"
    echo "$MS_ERROR] exiting without symlinking the dotfiles"
    exit 1
  fi
else
  echo "$MS_IDLE $MS_HIGHLIGHT$MS_OLDDIR$MS_DEFAULT] Directory for backup already exists"
fi

# change to the dotfiles directory
#echo "Changing to the $MS_DIR directory"
#cd $MS_DIR
#echo "...done\n"

# create symlinks
for file in $MS_FILES; do
  if [[ -e ~/.$file ]] ; then
    if [[ ! -L ~/.$file ]] ; then
      if [[ -f ~/$file ]] ; then
        echo "$move $MS_HIGHLIGHT~/.$file$MS_DEFAULT] Move from ~ to $MS_OLDDIR"
        mv ~/.$file $MS_OLDDIR/
        echo "$MS_CREATE $MS_HIGHLIGHT~/.$file$MS_DEFAULT] Creating symlink in home directory"
        mkdir -p ~/.${file%/*}
        ln -s -f $MS_DIR/$file ~/.$file
      else
        if [[ -d ~/$file ]] ; then
          echo "$MS_ERROR $MS_HIGHLIGHT~/.$file$MS_DEFAULT] ~/.$file is a directory and not a file. Can't make a symlink"
        else
          if [[ ${file##*.} -eq $MS_ENDING ]] ; then
            echo "$move $MS_HIGHLIGHT~/.$file$MS_DEFAULT] Move from ~ to $MS_OLDDIR"
            mv ~/.$file $MS_OLDDIR/
            echo "$MS_CREATE $MS_HIGHLIGHT~/.$file$MS_DEFAULT] Creating symlink in home directory"
            mkdir -p ~/.${file%/*}
            ln -s -f $MS_DIR/$file ~/.$file
          else
            echo "$MS_ERROR $MS_HIGHLIGHT~/.$file$MS_DEFAULT] ~/.$file is not a symlink, or file, or directory. Can't make a Symlink"
          fi
        fi
      fi
    else
      echo "$MS_DELETE $MS_HIGHLIGHT~/.$file$MS_DEFAULT] is a symlink and will be deletet"
      rm ~/.$file
      echo "$MS_CREATE $MS_HIGHLIGHT~/.$file$MS_DEFAULT] Creating symlink in home MS_DIRectory"
      ln -s -f $MS_DIR/$file ~/.$file
    fi
  else
    echo "$MS_INFO $MS_HIGHLIGHT~/.$file$MS_DEFAULT] file doesnt exist"
    echo "$MS_CREATE $MS_HIGHLIGHT~/.$file$MS_DEFAULT] Creating symlink in home directory"
    ln -s -f $MS_DIR/$file ~/.$file
  fi
done

# create symlinks
for folder in $MS_FOLDERS; do
  if [[ ! -d $MS_OLDDIR/${folder%/*} ]] ; then
    echo "$MS_CREATE $MS_HIGHLIGHT~/.$folder/$MS_DEFAULT] Creating Directory"
    mkdir -p $MS_OLDDIR/${folder%/*}
  else
    echo "$MS_IDLE $MS_HIGHLIGHT~/.$folder/$MS_DEFAULT] Directory already exists"
  fi
  if [[ ! -L ~/.$folder ]] ; then
    if [[ -e ~/.$folder ]]
    then
      if [[ -d ~/.$folder ]] ; then
        echo "$MS_MOVE $MS_HIGHLIGHT~/.$folder$MS_DEFAULT] Move from ~/.$folder/ to $MS_OLDDIR"
        mv ~/.$folder/ $MS_OLDDIR/$folder
        echo "$MS_CREATE $MS_HIGHLIGHT$folder$MS_DEFAULT] Creating Symlink ~/.${folder%/*}/"
        ln -s -f -r $MS_DIR/$folder/ ~/.${folder%/*}/
      else
        echo "$MS_ERROR $MS_HIGHLIGHT$folder$MS_DEFAULT] file already exists but its not a Folder!"
      fi
    else
      echo "$MS_CREATE $MS_HIGHLIGHT$folder$MS_DEFAULT] Creating Symlink ~/.${folder%/*}/"
      ln -s -f -r $MS_DIR/$folder/ ~/.${folder%/*}/
    fi
  else
    echo "$MS_DELETE $MS_HIGHLIGHT~/.$folder$MS_DEFAULT] is a symlink and will be deletet"
    rm -r ~/.$folder
    echo "$MS_CREATE $MS_HIGHLIGHT~/.$folder$MS_DEFAULT] Creating symlink ~/.${folder%/*}/"
    ln -s -f -r $MS_DIR/$folder/ ~/.${folder%/*}/
  fi
done

echo "...done"
exit 0
