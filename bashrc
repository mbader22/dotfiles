# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

export BASH_DIR=~/.zsh

source $BASH_DIR/aliases.zsh
source $BASH_DIR/functions.zsh
eval "$(dircolors -b ~/.dircolors)"
