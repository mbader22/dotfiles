# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

export BASH_DIR=~/.bash

source $BASH_DIR/aliases
source $BASH_DIR/functions
