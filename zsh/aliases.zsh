alias bashrc="vim ~/.bashrc"
alias vimrc="vim ~/.vimrc"
alias zshrc="vim ~/.zshrc"
alias aliases="vim ~/dotfiles/zsh/aliases.zsh"
alias functions="vim ~/dotfiles/zsh/functions.zsh"
alias m="mplayer"

#InvoicePlane
alias invoiceplaneUpdate="rm application/config/database.php application/language/German/custom_lang.php && rm -r application/views/ && ln -s ~/public_html/ip_dotfiles/application/config/database.php application/config/database.php && ln -s ~/public_html/ip_dotfiles/application/language/German/custom_lang.php application/language/German/custom_lang.php && cp -rs ~/public_html/ip_dotfiles/application/views application/views && cp  ~/public_html/ip_dotfiles/ipconfig.php ipconfig.php && sudo chmod a+w -R uploads application/logs && sudo chmod a+w ipconfig.php && sudo chmod a+w -R vendor/mpdf/mpdf/tmp && echo 'http://localhost/~markus/${PWD##*/}/index.php/setup oeffnen' "

# Easier navigation: .., ..., ...., ....., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~" # `cd` is probably faster to type though

#grive
alias grive2="grive --id 230690228363-da68fv3rfv2l7tug6umvd6ckfe9lb7n0.apps.googleusercontent.com --secret 2DRt4ige636haDLnsT76g90M"

#MariaDB
alias MariaDBBackup="mysqldump  --all-databases -u root -p | gzip > /home/markus/gdrive-Markus/Documents/Arbeiten/InvoicePlane/Backup/all_databases-`date +%Y-%m-%d`.sql.gz"
#alias MariaDBBackup="mysqldump --single-transaction --flush-logs --master-data=2 --all-databases -u root -p | gzip > /home/markus/Documents/Arbeiten/InvoicePlane/Backup/all_databases-`date +%Y-%m-%d`.sql.gz"

#2fa
alias 2fa=~/.2fa/decrypt.key.sh

# expand /tmp directory temporarily
alias tmpResizeTo4M="sudo mount -o remount,size=4G,noatime /tmp"
# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
    colorflag="--color"
    else # OS X `ls`
        colorflag="-G"
        fi

# temporarily resize \tmp
alias resizetmp="sudo mount -o remount,size=4G,noatime /tmp"

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
