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

export TMOUT=10000

# Bash Completion
if [ -f /usr/share/bash-completion/bash_completion ]; then
  . /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

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

helpFunctions(){
  echo "custom functions:"
  echo "printYaml - pretty print a yaml file (requires python and PyYAML)"
  echo "rmKnownHost - remove a known host from the ~/.ssh/known_hosts file"
  echo "ytdl - download a youtube video using the best quality (requires python and yt-dlp)"
  echo "----file related----"
  echo "fdir - find files matching iname in CWD and exclude directory eg: fdir iname /etc"
  echo "ff - find files containing iname in CWD"
  echo "swap - swap two files (if they exist)"
  echo "extract - extract an archive using the appropriate extractor for the file extension"
  echo "----process related----"
  echo "my_ps - list processes for the current user"
  echo "mydf - modified df output"
  echo "ii - host related info"
  echo "psgrep - return processes matching a grep expression without the grep process itself included."
  echo "extrename - rename files in a directory that match an extension so they include a counter."
  echo "  This searches the directory recursively and puts all the renamed files in the base of the directory."
  echo "  syntax: `extrename <directory> <extension> <new_name>`"
  echo "  example: `extrename documents txt doc` will rename all `.txt` files in the `documents`"
  echo "           directory so the filenames look like `doc-000.txt`, `doc-001.txt`..."
}

# Document ssh tunnel command (this is harder to remember than tar commands)
helpSshTunnel(){
  echo "Open a local port to forward to a remote port:"
  echo "  ssh -L <local_port>:<host>:<remote_port> <user>@<host>"
  echo "  eg: ssh -L [local_ip:]8888:192.168.1.20:80 user@192.168.1.5"
  echo "  notes: forwards localhost traffic on 8888 to 192.168.1.20:80 "
  echo "         via the ssh connection to 192.168.1.5."
  echo "Create a dynamic port forwarding with SOCKS:"
  echo "  ssh -D <port> <user>@<host>"
  echo "  notes: Prior to <local_port> a hostname may be used for any of the"
  echo "         above commands. If omitted, localhost is used by default."
  echo "Open a port on the remote ssh server that exposes a local port:"
  echo "  ssh -R [remote_ip:]<remote_port>:<local_host>:<local_port> <user>@<host>"
  echo "  notes: If [remote_ip:] is omitted, all interfaces are used on the ssh"
  echo "         server. Otherwise only the interface with the IP is used."
}

helpFind(){
  echo "Common find command examples:"
  echo "============================="
  echo "Find all directories in the current directory (no recursing)"
  echo "> find . -maxdepth 1 -type d" 
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

helpVlc(){
  echo -e "play video rotated 90 degrees"
  echo "vlc --avcodec-hw none --video-filter transform --transform-type 90 suzuki.mp4"
  echo -e "stream video to multicast address"
  echo "vlc suzuki.mp4 --sout '#rtp{mux=ts,dst=239.239.239.230,port=8989}'"
}

helpColors(){
  echo -e "Black, Red, Green, Yellow, Blue, Purple, Cyan, White"
  echo -e $Black"Black, "$Red"Red, "$Green"Green, "$Yellow"Yellow, "\
$Blue"Blue, "$Purple"Purple, "$Cyan"Cyan, "$White"White "$NC
  echo -e $BBlack"BBlack,"$BRed"BRed,"$BGreen"BGreen,"$BYellow"BYellow,"\
$BBlue"BBlue,"$BPurple"BPurple,"$BCyan"BCyan,"$BWhite"BWhite,"$NC
  echo -e "Append a \"B\" for bold or \"On_\" for background colors"
  echo -e "To reset the color use just \"NC\""
}

helpFfmpeg(){
  echo -e 'Convert mp4 to gif example'
  echo -e 'ffmpeg -i PXL_20240222_235639706.TS.mp4 -vf "fps=10,scale=320:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" -loop 0 breaker-flip.gif'
}

# List defined help message functions
helpers(){
  echo "helper functions:"
  echo "  helpFunctions"
  echo "  helpSshTunnel"
  echo "  helpFind"
  echo "  helpLs"
  echo "  helpVlc"
  echo "  helpColors"
  echo "  helpFfmpeg"
  echo "  aliases"
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

# Function to print a yaml file as it is interpreted by python's yaml module
printYaml(){
  if /usr/bin/env python -c 'import sys,yaml; yaml.dump(yaml.load(sys.stdin),sys.stdout, indent=4)' 2>/dev/null; then
    echo ""
  else
    /usr/bin/env python -c 'import sys,yaml; yaml.dump(yaml.load(sys.stdin, Loader=yaml.Loader),sys.stdout, indent=4)'
  fi
}

ytdl(){
  yt-dlp -f bestvideo+bestaudio/best "$1"
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

# Rename files in a directory (recursive) matching an extension to a prefix-`zero padded counter`
# based on date
function extrename(){
  _DIR=$1
  _EXT=$2
  _NEW_NAME=$3
  COUNTER=0
  # -printf "%p" shows the file with the path, "%f" shows just the file
  for i in $(find $_DIR -type f -iname "*.$_EXT" -printf "%T+\t%p\n" | sort | cut -f 2); do
    printf -v ZCOUNT '%03d' $COUNTER
    mv $i $(dirname $i)/$_NEW_NAME-$ZCOUNT.$_EXT
    ((COUNTER=COUNTER+1))
  done
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


# Fix gnome to minimize windows when their icon is clicked on the taskbar
[[ $(grep -P "Ubuntu|jammy" /etc/lsb-release | wc -l) -eq 3 ]] && gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'

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
