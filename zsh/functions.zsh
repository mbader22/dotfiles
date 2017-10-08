# navigation

mkcd () {
  mkdir "$1"
  cd "$1"
}

# github
getDotfilesFromGithub(){
  cd ~/dotfiles
  git update-index -q --refresh
  CHANGED=$(git diff-index --name-only HEAD --)
  if [ ! -z "$CHANGED" ] ; then
    gs
    echo "\nlokale Änderungen noch nicht mit Github synchronisiert!"
    read "brave?Trotzdem fortfahren (Y|n)?"
    if [[ "$brave" =~ ^[Yy]$ ]]
    then
      [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
    fi
  fi
  sudo rm -r ~/dotfiles
  if [ $? = 0 ] ; then
    cd ~/
    git clone https://github.com/mbader22/dotfiles.git
    . ~/dotfiles/fullsetup.sh
    return 0
  else
    return 1
  fi
}

# youtube-dl

#extracts audio from youtube videos
y2a(){
  youtube-dl -ci -o "%(title)s.%(ext)s" "$@" -x
}

#extracts audio from youtube videos
y2v(){
  youtube-dl -ci -o "%(title)s.%(ext)s" "$@"
}

y2mplayer(){
  youtube-dl -q -o- ${1} | mplayer -
}

#Bilder für Homepage vorbereiten
homepage(){
  for i in *; do mv $i `echo $i | tr [:upper:] [:lower:]`; done
  mkdir thumbs
  gimp -i -b '(batch-homepage-large-sharpen "*.jpg" 640 480)' -b '(gimp-quit 0)'
  notify-send 'Homepage' 'Vorschaubilder vollständig erstellt!' --icon=dialog-information
}

#Rechnungen erstellen
rechnungen(){
  if [ ${#} -eq 0 ]
  then
    echo ".tex Datei als Parameter angeben!"
  else
    if [ ${#} -eq 1 ]
    then
      vim ${1}
      lat2pdf ${1}
      exit 0
    else
      echo ".tex Datei als Parameter angeben!"
    fi
  fi
}

#arch Linux aktualisieren und System herunterfahren
asd(){
  pacaur -Syyu --noconfirm --noedit
  if (($? == 0))
  then
    xfce4-session-logout -h
  fi
}
#arch Linux aktualisieren
a(){
  readonly A_FALSCHE_PARAMETER="von a unterstützte Parameter:\n\n-a auffrischen der kompletten Package Listen mit anschließenden System Upgrade\n"

  if [ ${#} -eq 0 ] ; then
    #pacaur -Syu
    pacaur -Syyu --noconfirm --noedit
    if [ "$?" = 0 ] ; then
      notify-send 'Software aktualisieren' 'Systemupdate abgeschlossen' --icon=system-software-update
      exit 0
    else
      notify-send 'Software aktualisieren' 'Systemupdate gescheitert' --icon=system-software-update
      return 1
    fi
  else
    if [ ${#} -gt 1 ]
    then
      echo -e ${A_FALSCHE_PARAMETER}
      return 1
    else
      if [ "${1}" = "-a" ]
      then
        pacaur -Syyu --noconfirm --noedit
        if [ $? = 0 ] ; then
          notify-send 'Software aktualisieren' 'Systemupdate abgeschlossen' --icon=system-software-update
          exit 0
        else
          notify-send 'Software aktualisieren' 'Systemupdate gescheitert' --icon=system-software-update
          return 1
        fi
      else
        echo -e ${A_FALSCHE_PARAMETER}
        return 1
      fi
    fi
  fi
}

#Latex>pdf

lat2pdf(){
  ERROR="Too few arguments : no file name specified"

  if [ $# -eq 0 ]
  then
    echo $ERROR # no args? ... print error and exit
  else

    # check that the file exists
    if [ -f "$@" ]
    then
      # if it exists then latex it twice, dvips, then ps2pdf, then remove all the unneeded files
      pdflatex "$@"
      pdflatex "$@"

      # these lines can be appended to delete other files, such as *.out
      rm *.aux
      rm *.log
      rm *.toc
      rm *.out
    else
      # otherwise give this output line with a list of available tex files
      echo -e "the file doesnt exist butthead! Choose one of these:"
      ls *.tex
    fi
  fi
}

#Textdokument scannen

td-scannen(){
mkdir ~/bin/neuu
notify-send 'textdokument-scannen' 'scannen abgebrochen' --icon=simple-scan
source /home/markus/bin/td-scannen.cfg

in_optionen=$(zenity --forms --title="Textdokument Scannen und komprimieren" --text="Einstellungen" --separator="," --add-entry="Dateiname" --add-entry="Scanauflösung |75|150|300|600dpi (${resolution})" --add-entry="modus g|gray|grayscale (${mode})" --add-entry="Längste Seite(${max_length})")

if (($? != 0))
then
  echo "abbruch"
  exit 1
fi

in_dateiname=$(awk -F, '{print $1}' <<<$in_optionen)
in_scanaufloesung=$(awk -F, '{print $2}' <<<$in_optionen)
in_modus=$(awk -F, '{print tolower($3)}' <<<$in_optionen)
in_laengsteseite=$(awk -F, '{print $4}' <<<$in_optionen)


if [ ${#in_dateiname} -gt 0 ]
then
  dateiname="$(pwd)/${in_dateiname}($(date +"%d-%m-%Y_%H:%M:%S")).pnm"
else
  dateiname="$(pwd)/${filename}($(date +"%d-%m-%Y_%H:%M:%S")).pnm"
fi

if [ ${#in_scanaufloesung} -gt 0 ]
then
  resolution=${in_scanaufloesung}
fi

if [ ${#in_laengsteseite} -gt 0 ]
then
  max_length=${in_laengsteseite}
fi

if [ ${#in_modus} -gt 0 ]
then
  if [ ${in_modus} = "g" ]  || [ ${in_modus} = "gray" ] || [ ${in_modus} = "grayscale" ]
  then
    mode="Gray"
    num_colors=4
  fi
fi

errorstat=$?


for ((i=1;i<=${scanversuche};i++))
do
  if [ ${i} = 1 ]
  then
    notify-send 'textdokument-scannen' 'scannen gestartet' --icon=simple-scan
  else
    notify-send 'textdokument-scannen' "scannen fehlgeschlagen, starte scannen erneut(${i})" --icon=simple-scan
  fi

  ( # the pipe creates an implicit subshell; marking it explicit
  ( scanimage -p --resolution ${resolution} --mode "${mode}" 2>"$logfile" > "${dateiname}"; echo "100")& echo $!
  ) | (
  read PIPED_PID; zenity --progress --title Textdokument scannen --text "Scanning..." --percentage=0 --auto-close --pulsate && exit 0 || kill ${PIPED_PID} && exit 1
  )
  errorstat=$?

  scannen_fehlgeschlagen=0
  if [ $errorstat = 0 ]
  then
    if grep -q "100" "${logfile}"
    then
      scannen_fehlgeschlagen=0
      echo "scannen erfolgreich"
    else
      scannen_fehlgeschlagen=1
      errorstat=1
      echo "scannen fehlgeschlagen"
    fi
  fi

  if ( [ $errorstat = 0 ] )
  then
    notify-send 'textdokument-scannen' 'scannen abgeschlossen, starte Dateikomprimierung' --icon=simple-scan
    (gimp -i -b '(skript-fu-scan-verkleinern "'"${dateiname}"'" '${max_length}' '${num_colors}')' -b '(gimp-quit 0)'&& echo "100") |
    (zenity --progress --title Textdokument scannen --text "Dateikomprimierung..." --percentage=0 --auto-close --pulsate)
    errorstat=$?
    rm "${dateiname}"
    if [ $errorstat = 0 ]
    then
      rm "${logfile}"
      echo "dokument erfolgreich erstellt"
      notify-send 'textdokument-scannen' 'Dokument erfolgreich erstellt!' --icon=simple-scan
      exit 0
    fi
  elif [ $scannen_fehlgeschlagen = 0 ]
  then
    echo "abbruch"
    rm "${logfile}"
    rm "${dateiname}"
    notify-send 'textdokument-scannen' 'scannen abgebrochen' --icon=simple-scan
    exit 1
  fi
done

rm "${dateiname}"
notify-send 'textdokument-scannen' 'scannen gescheitert, Programm wird beendet' --icon=simple-scan
exit 1
}
