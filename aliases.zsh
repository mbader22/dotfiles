alias bashrc="vim ~/.bashrc"
alias vimrc="vim ~/.vimrc"
alias aliases="vim ~/dotfiles/aliases"
alias functions="vim ~/dotfiles/functions"
alias m="mplayer"

# Easier navigation: .., ..., ...., ....., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~" # `cd` is probably faster to type though

# Shortcuts
alias r="cd ~/Documents/Arbeiten/Rechnungen/2016"

# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
    colorflag="--color"
    else # OS X `ls`
        colorflag="-G"
        fi

# List all files colorized in long format
alias l="ls -lF ${colorflag}"

# Always use color output for `ls`
alias ls="command ls ${colorflag}"
export=LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'

# Enable aliases to be sudo’ed
alias sudo='sudo '

alias :q="exit"
alias ä="exit"

#shutdown
alias sd="sudo shutdown -h"
alias sdc="sudo shutdown -c"

#Textdateien recodieren
alias win2lin="recode windows-1252..UTF-8"
alias lin2win="recode UTF-8..windows-1252"

alias path='echo $PATH | tr ":" "\n" | sort'    # print $path nicely
alias mkdir='mkdir -p'                          # creat dirs recursively

# helpers (defaults)
alias grep='grep --color=auto'                  # color grep matches
alias count='wc -l'                             # count lines
alias size='du -sh'                             # get folder size
alias sizer='du -h -c'                          # get and print folder size for all folders, recursively
alias disks='df -H -l'                          # show available disk space
alias ip='ifconfig | grep "inet "'              # quickly print ip address
alias ping='ping -c 5'                          # pings with 5 packets, not unlimited

# git
alias gs='git status'
alias ga='git add -A'
alias gp='git push origin HEAD'
alias gd='git difftool'
alias gc='git commit -m'
alias gl='git log -n 20 --format="%ai  %Cgreen[%h]%Creset  [%<(12,trunc)%aN]  %s"'