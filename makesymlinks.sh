#!/bin/zsh
############################
# makesymlinks.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

error="[\e[31merror\e[0m"
info="[\e[32minfo\e[0m"
move="[\e[32mmove\e[0m"
delete="[\e[32mdelete\e[0m"
create="[\e[32mcreate\e[0m"
idle="[\e[32midle\e[0m]"
highlight="\e[97m"
default="\e[0m"
########## Variables

dir=~/dotfiles                    # dotfiles directory
files=('zsh/aliases.zsh' 'zsh/functions.zsh' 'bashrc' 'vimrc' 'zshrc' 'config/Thunar/uca.xml' 'dircolors' 'config/xfce4/terminal/terminalrc')    # list of files/folders to symlink in homedir
folders=('gimp-2.8/scripts')
##########

# create dotfiles_old in homedir
olddir=~/dotfiles_old             # old dotfiles backup directory
if [[ ! -d $olddir ]]
then
  if [[ ! -a $olddir ]]
  then
    echo "$create $highlight$olddir$default] Creating for backup of any existing dotfiles in ~"
    mkdir -p $olddir
    echo "...done\n"
  else
    echo "$error] $highlight$olddir$default already exists and is not an directory"
    echo "$error] rename or remove file $highlight$olddir$default before starting this symlink script"
    echo "$error] exiting without symlinking the dotfiles"
    exit 1
  fi
else
  echo "$idle Folder $highlight$olddir$default for backup already exists"
fi

# change to the dotfiles directory
#echo "Changing to the $dir directory"
#cd $dir
#echo "...done\n"

# create symlinks
for file in $files; do
  if [[ -e ~/.$file ]]
  then
    if [[ ! -L ~/.$file ]]
    then
      if [[ -f ~/$file ]]
      then
        echo "$move $highlight~/.$file$default] Move from ~ to $olddir"
        mv ~/.$file $olddir/
        echo "$create $highlight~/.$file$default] Creating symlink in home directory"
        ln -s $dir/$file ~/.$file
      else
        if [[ -d ~/$file ]]
        then
          echo "$error $highlight~/.$file$default] ~/.$file is a directory and not a file. Can't make a symlink"
        else
          echo "$error $highlight~/.$file$default] ~/.$file is not a symlink, or file, or directory. Can't make a Symlink"
        fi
      fi
    else
      echo "$delete $highlight~/.$file$default] is a symlink and will be deletet"
      rm ~/.$file
      echo "$create $highlight~/.$file$default] Creating symlink in home directory"
      ln -s $dir/$file ~/.$file
    fi
  else
    echo "$info $highlight~/.$file$default] file doesnt exist"
    echo "$create $highlight~/.$file$default] Creating symlink in home directory"
    ln -s $dir/$file ~/.$file
  fi
done

# create symlinks
for folder in $folders; do
  if [[ ! -d $olddir/${folder%/*} ]]
  then
    echo "$create $highlight~/.$folder/$default] Creating Directory"
    mkdir $olddir/${folder%/*}
  else
    echo "$idle Directory $highlight~/.$folder/$default already exists"
  fi
  if [[ ! -L ~/.$folder ]]
  then
    if [[ -e ~/.$folder ]]
    then
      if [[ -d ~/.$folder ]]
      then
        echo "$move $highlight~/.$folder$default] Move from ~ to $olddir"
        mv ~/.$folder/ $olddir/$folder
        echo "$create $highlight$folder$default] Creating Symlink in home directory"
        ln -s -r $dir/$folder/ ~/.${folder%/*}/
      else
        echo "$error $highlight$folder$default] file already exists but its not a Folder!"
      fi
    else
      echo "$create $highlight$folder$default] Creating Symlink in home directory"
      ln -s -r $dir/$folder/ ~/.${folder%/*}/
    fi
  else
      echo "$delete $highlight~/.$folder$default] is a symlink and will be deletet"
      rm -r ~/.$folder
      echo "$create $highlight~/.$folder$default] Creating symlink in home directory"
      ln -s -r $dir/$folder/ ~/.${folder%/*}/
  fi
done

echo "...done\n"
