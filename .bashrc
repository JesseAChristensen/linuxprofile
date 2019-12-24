# =============================================================== #
# PERSONAL $HOME/.bashrc
# By Emmanuel Rouat [no-email]
# Edited by Jesse Christensen

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Source global definitions (if any)
if [ -f /etc/bashrc ]; then
      . /etc/bashrc   # --> Read /etc/bashrc, if present.
fi

function _exit()              # Function to run upon exit of shell.
{
    echo -e "Thank you, come again!"
}
trap _exit EXIT

#-------------------------------------------------------------
#  settings
#-------------------------------------------------------------
#set -o nounset     # These  two options are useful for debugging.
#set -o xtrace
alias debug="set -o nounset; set -o xtrace"

ulimit -S -c 0      # Don't want coredumps.
set -o notify
set -o noclobber
set -o ignoreeof

# Enable options:
# See https://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html
shopt -s cdspell # corrects minor errors in directory spelling when using `cd`
shopt -s cdable_vars # if the directory arg for the `cd` command doesn't exist, try $arg instead
shopt -s checkhash
shopt -s checkwinsize # updates $LINES and $COLUMNS after each non-builtin command
shopt -s sourcepath
shopt -s no_empty_cmd_completion
shopt -s cmdhist # save all lines of a multiline command as a single history entry
shopt -s histappend histreedit histverify
shopt -s extglob       # Necessary for programmable completion.
shopt -s hostcomplete # attempt hostname completion when a word contains a `@`
# Disable options:
shopt -u mailwarn
unset MAILCHECK        # Don't want my shell to warn me of incoming mail.

# Add pycharm to PATH if pycharm exists
PYCHARM_BIN_PATH="$HOME/bin/pycharm-professional-2017.1.8/bin"
if [ -e $PYCHARM_BIN_PATH ]; then
  PATH="$PATH:$PYCHARM_BIN_PATH"
fi

export TMOUT=10000

#-------------------------------------------------------------
#  color definitions
#-------------------------------------------------------------
# Normal Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

# Bold
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

# Background
On_Black='\e[40m'       # Black
On_Red='\e[41m'         # Red
On_Green='\e[42m'       # Green
On_Yellow='\e[43m'      # Yellow
On_Blue='\e[44m'        # Blue
On_Purple='\e[45m'      # Purple
On_Cyan='\e[46m'        # Cyan
On_White='\e[47m'       # White

NC="\e[m"               # Color Reset

ALERT=${BWhite}${On_Red} # Bold White on red background

#============================================================
# Help message functions
#============================================================

helpColors(){
  echo -e "Black, Red, Green, Yellow, Blue, Purple, Cyan, White"
  echo -e $Black"Black, "$Red"Red, "$Green"Green, "$Yellow"Yellow, "\
$Blue"Blue, "$Purple"Purple, "$Cyan"Cyan, "$White"White "$NC
  echo -e $BBlack"BBlack,"$BRed"BRed,"$BGreen"BGreen,"$BYellow"BYellow,"\
$BBlue"BBlue,"$BPurple"BPurple,"$BCyan"BCyan,"$BWhite"BWhite,"$NC
  echo -e "Append a \"B\" for bold or \"On_\" for background colors"
  echo -e "To reset the color use just \"NC\""
}

# Document ssh tunnel command (this is harder to remember than tar commands)
helpSshTunnel(){
  echo "-L local_port:remote_ip_address:remote_port"
  echo "eg:"
  echo "ssh -L 8888:192.168.1.20:80 user@192.168.1.5"
  echo "tunnel localhost:8888 traffic through to the ssh server which sends that"
  echo "traffic on to 192.168.1.20:80"
}

helpFind(){
  echo "aliases:"
  echo ""
}

helpVlc(){
  echo -e "play video rotated 90 degrees"
  echo "vlc --avcodec-hw none --video-filter transform --transform-type 90 suzuki.mp4"
  echo -e "stream video to multicast address"
  echo "vlc suzuki.mp4 --sout '#rtp{mux=ts,dst=239.239.239.230,port=8989}'"
}

helpCd(){
  echo "cdetc='cd /etc'"
  echo "cdans='cd /etc/ansible'"
  echo "cdsup='cd /etc/supervisord.d/'"
  echo "cdlog='cd /var/log'"
  echo "cdnet='cd /etc/sysconfig/network-scripts'"
  echo "cdsys='cd /etc/sysconfig'"
  echo "cdblk='cd /sys/block'"
  echo "cdweb='cd /var/www/html'"
}

helpLs(){
  echo "lx=Sort by extension"
  echo "lk=Sort by size, biggest last."
  echo "lu=Sort by/show access time,most recent last"
  echo "ll=Group directories first"
  echo "la=Group directories first and include hidden files"
  echo "thor=Sort by modification date in reverse order"
  echo "treec=improved tree output"
}

helpFunctions(){
  echo "custom functions:"
  echo "printYaml - pretty print a yaml file (requires python and PyYAML)"
  echo "ytld - download a youtube video using the best quality (requires python and youtube-dl"
  echo "----file related----"
  echo "fdir - find files matching iname in CWD and exclude directory eg: fdir iname /etc"
  echo "ff - find files containing iname in CWD"
  echo "swap - swap two files (if they exist)"
  echo "extract - extract an archive using the appropriate extractor for the file extension"
  echo "----process related----"
  echo "my_ps - list processes for the current user"
  echo "my_df - modified df output"
  echo "ii - host related info"
  echo "psgrep - return processes matching a grep expression without the grep process itself included."
}

# List defined help message functions
helpers(){
  echo "helper functions:"
  echo "  helpColors"
  echo "  helpSshTunnel"
  echo "  helpFind"
  echo "  helpVlc"
  echo "  helpCd"
  echo "  helpLs"
  echo "  helpFunctions"
}

#============================================================
#  ALIASES
#============================================================

#-------------------
# Personnal Aliases
#-------------------
if [[ -f ~/.aliases ]]; then
  source ~/.aliases
fi
#-------------------
# Private (non git managed) Aliases
#-------------------
if [[ -f ~/.privatealiases ]]; then
  source ~/.privatealiases
fi

#============================================================
#  CUSTOM FUNCTIONS
#============================================================

# Function to remove host from the ~/.ssh/known_hosts file
rmKnownHost(){
  for eachHost in $@; do
    IPTODEL=$(dig $eachHost | awk "/^$eachHost/{print \$5}")
    ssh-keygen -f ~/.ssh/known_hosts -R $eachHost
    ssh-keygen -f ~/.ssh/known_hosts -R $IPTODEL
  done
}

# Function to pretty print a yaml file
printYaml(){
  python -c 'import sys,yaml; yaml.dump(yaml.load(sys.stdin),sys.stdout, indent=4)'
}

ytdl(){
  youtube-dl -f bestvideo+bestaudio/best "$1"
}

# Find iname $1 and exclude directory $2:
function fdir() { find . -not \( -path "$2" -prune \) -iname "$1" ; }

# Find a file with a pattern in name:
function ff() { find . -type f -iname '*'"$*"'*' -ls ; }

function swap(){
  local TMPFILE=tmp.$$
  [ $# -ne 2 ] && echo "swap: 2 arguments needed" && return 1
  [ ! -e $1 ] && echo "swap: $1 does not exist" && return 1
  [ ! -e $2 ] && echo "swap: $2 does not exist" && return 1
  mv "$1" $TMPFILE
  mv "$2" "$1"
  mv $TMPFILE "$2"
}

function extract(){
  if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2)   tar xvjf $1     ;;
          *.tar.gz)    tar xvzf $1     ;;
          *.bz2)       bunzip2 $1      ;;
          *.rar)       unrar x $1      ;;
          *.gz)        gunzip $1       ;;
          *.tar)       tar xvf $1      ;;
          *.tbz2)      tar xvjf $1     ;;
          *.tgz)       tar xvzf $1     ;;
          *.zip)       unzip $1        ;;
          *.Z)         uncompress $1   ;;
          *.7z)        7z x $1         ;;
          *)           echo "'$1' cannot be extracted via >extract<" ;;
      esac
  else
      echo "'$1' is not a valid file!"
  fi
}

function my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,bsdtime,command ; }

# prettier df output
function mydf(){
  for fs ; do
      if [ ! -d $fs ]
      then
        echo -e $fs" :No such file or directory" ; continue
      fi
      local info=( $(command df -P $fs | awk 'END{ print $2,$3,$5 }') )
      local free=( $(command df -Pkh $fs | awk 'END{ print $4 }') )
      local nbstars=$(( 20 * ${info[1]} / ${info[0]} ))
      local out="["
      for ((j=0;j<20;j++)); do
          if [ ${j} -lt ${nbstars} ]; then
             out=$out"*"
          else
             out=$out"-"
          fi
      done
      out=${info[2]}" "$out"] ("$free" free on "$fs")"
      echo -e $out
  done
}

# Get current host related info.
function ii(){
  echo -e "${BRed}distro information:$NC"; uname -a
  echo -e "${BRed}Users logged onto this system:$NC"
  w -hs | cut -d " " -f1 | sort | uniq
  echo -e "${BRed}uptime:$NC "; uptime
  echo -e "${BRed}memory stats:$NC "; free -h
  echo -e "${BRed}diskspace:$NC "; mydf / $HOME
  echo -e "${BRed}internet facing IP Address :$NC" ; getExternalIp
  echo -e "${BRed}Open connections :$NC "; netstat -pan --inet;
  echo
}

function psgrep(){
  expression="$1"
  ps -ef | grep $expression | sed '/grep/d'
}

#============================================================
# terminal prompt settings
#============================================================
if [[ -e /usr/bin/tmux ]]; then
  if [[ -z $TMUX ]]; then
    if [[ -z $SSH_CONNECTION ]]; then
      /usr/bin/tmux
    fi
  fi
fi

if [[ $UID -eq 0 ]]; then
  _UNAMECOLOR=$BRed
else
  _UNAMECOLOR=$Green
fi
if [[ -z $SSH_TTY ]]; then 
  _HNAMECOLOR=$Green
else
  _HNAMECOLOR=$BGreen
fi

# Fix for debian terminals showing old host information after a closed ssh session
case "$TERM" in
xterm*|rxvt*)
  PS1="${debian_chroot:+($debian_chroot)}\[$_UNAMECOLOR\]\u\[$Purple\]@\[$_HNAMECOLOR\]\h\[$Purple\]:\[$Green\]\w/\[$_UNAMECOLOR\]\$\[$NC\] "
  ;;
*)
  ;;
esac

# Set the gnome terminal tab title
PROMPT_COMMAND='echo -ne "\033]0;`whoami`@`hostname`:`pwd`\007"'

#if [[ -e ~/linuxprofile ]]; then
#  pushd ~/linuxprofile 2>&1 1>/dev/null
#  ./timeout.sh -t 2 -d 2 git fetch 1>/dev/null
#  ./timeout.sh -t 2 -d 2 git merge origin/master 1>/dev/null
#  ./install.sh -f 1>/dev/null
#  popd 2>&1 1>/dev/null || cd ~/
#fi
