# =============================================================== #
#
# PERSONAL $HOME/.bashrc FILE for bash-3.0 (or later)
# By Emmanuel Rouat [no-email]
# Edited by Jesse Christensen


# If not running interactively, don't do anything
[ -z "$PS1" ] && return


#-------------------------------------------------------------
# Source global definitions (if any)
#-------------------------------------------------------------


if [ -f /etc/bashrc ]; then
      . /etc/bashrc   # --> Read /etc/bashrc, if present.
fi

#-------------------------------------------------------------
# Exit function
function _exit()              # Function to run upon exit of shell.
{
    echo -e "${BRed}Thank you, come again!${NC}"
}
trap _exit EXIT
#-------------------------------------------------------------

#-------------------------------------------------------------
# Some settings
#-------------------------------------------------------------

#set -o nounset     # These  two options are useful for debugging.
#set -o xtrace
alias debug="set -o nounset; set -o xtrace"

ulimit -S -c 0      # Don't want coredumps.
set -o notify
set -o noclobber
set -o ignoreeof


# Enable options:
shopt -s cdspell
shopt -s cdable_vars
shopt -s checkhash
shopt -s checkwinsize
shopt -s sourcepath
shopt -s no_empty_cmd_completion
shopt -s cmdhist
shopt -s histappend histreedit histverify
shopt -s extglob       # Necessary for programmable completion.

# Disable options:
shopt -u mailwarn
unset MAILCHECK        # Don't want my shell to warn me of incoming mail.


#-------------------------------------------------------------
# Greeting, motd etc. ...
#-------------------------------------------------------------

# Color definitions (taken from Color Bash Prompt HowTo).
# Some colors might look different of some terminals.
# For example, I see 'Bold Red' as 'orange' on my screen,
# hence the 'Green' 'BRed' 'Red' sequence I often use in my prompt.


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

helpColors(){
  echo -e "Black, Red, Green, Yellow, Blue, Purple, Cyan, White"
  echo -e $Black"Black, "$Red"Red, "$Green"Green, "$Yellow"Yellow, "\
$Blue"Blue, "$Purple"Purple, "$Cyan"Cyan, "$White"White "$NC
  echo -e $BBlack"BBlack,"$BRed"BRed,"$BGreen"BGreen,"$BYellow"BYellow,"\
$BBlue"BBlue,"$BPurple"BPurple,"$BCyan"BCyan,"$BWhite"BWhite,"$NC
  echo -e "Append a \"B\" for bold or \"On_\" for background colors"
  echo -e "To reset the color use just \"NC\""
}

ALERT=${BWhite}${On_Red} # Bold White on red background


#============================================================
#
#  ALIASES AND FUNCTIONS
#
#  Arguably, some functions defined here are quite big.
#  If you want to make this file smaller, these functions can
#+ be converted into scripts and removed from here.
#
#============================================================

# Add pycharm to PATH if pycharm exists
PYCHARM_BIN_PATH="$HOME/bin/pycharm-professional-2017.1.8/bin"
if [ -e $PYCHARM_BIN_PATH ]; then
  PATH="$PATH:$PYCHARM_BIN_PATH"
fi

export TMOUT=10000

# Document ssh tunnel command (this is harder to remember than tar commands)
tunnelHelp(){
  echo "-L local_port:remote_ip_address:remote_port"
  echo "eg:"
  echo "ssh -L 8888:192.168.1.20:80 user@192.168.1.5"
  echo "tunnel localhost:8888 traffic through to the ssh server which sends that"
  echo "traffic on to 192.168.1.20:80"
}

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

#-------------------
# Personnal Aliases
#-------------------
if [[ -f ~/.aliases ]]; then
  source ~/.aliases
fi
#-------------------
#-------------------------------------------------------------
# File & strings related functions:
#-------------------------------------------------------------


# Find iname $1 and exclude directory $2:
function fdir() { find . -not \( -path "$2" -prune \) -iname "$1" ; }

# Find a file with a pattern in name:
function ff() { find . -type f -iname '*'"$*"'*' -ls ; }

# Find a file with pattern $1 in name and Execute $2 on it:
function fe() { find . -type f -iname '*'"${1:-}"'*' \
-exec ${2:-file} {} \;  ; }

#  Find a pattern in a set of files and highlight them:
#+ (needs a recent version of egrep).
function fstr()
{
    OPTIND=1
    local mycase=""
    local usage="fstr: find string in files.
Usage: fstr [-i] \"pattern\" [\"filename pattern\"] "
    while getopts :it opt
    do
        case "$opt" in
           i) mycase="-i " ;;
           *) echo "$usage"; return ;;
        esac
    done
    shift $(( $OPTIND - 1 ))
    if [ "$#" -lt 1 ]; then
        echo "$usage"
        return;
    fi
    find . -type f -name "${2:-*}" -print0 | \
xargs -0 egrep --color=always -sn ${case} "$1" 2>&- | more

}


function swap()
{ # Swap 2 filenames around, if they exist (from Uzi's bashrc).
    local TMPFILE=tmp.$$

    [ $# -ne 2 ] && echo "swap: 2 arguments needed" && return 1
    [ ! -e $1 ] && echo "swap: $1 does not exist" && return 1
    [ ! -e $2 ] && echo "swap: $2 does not exist" && return 1

    mv "$1" $TMPFILE
    mv "$2" "$1"
    mv $TMPFILE "$2"
}

function extract()      # Handy Extract Program
{
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


# Creates an archive (*.tar.gz) from given directory.
function maketar() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }

# Create a ZIP archive of a file or folder.
function makezip() { zip -r "${1%%/}.zip" "$1" ; }

# Make your directories and files access rights sane.
function sanitize() { chmod -R u=rwX,g=rX,o= "$@" ;}

#-------------------------------------------------------------
# Process/system related functions:
#-------------------------------------------------------------


function my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,bsdtime,command ; }
function pp() { my_ps f | awk '!/awk/ && $0~var' var=${1:-".*"} ; }


function killps()   # kill by process name
{
    local pid pname sig="-TERM"   # default signal
    if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
        echo "Usage: killps [-SIGNAL] pattern"
        return;
    fi
    if [ $# = 2 ]; then sig=$1 ; fi
    for pid in $(my_ps| awk '!/awk/ && $0~pat { print $1 }' pat=${!#} )
    do
        pname=$(my_ps | awk '$1~var { print $5 }' var=$pid )
        if ask "Kill process $pid <$pname> with signal $sig?"
            then kill $sig $pid
        fi
    done
}

function mydf()         # Pretty-print of 'df' output.
{                       # Inspired by 'dfc' utility.
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


function my_ip() # Get IP adress on ethernet.
{
    MY_IP=$(/sbin/ifconfig eth0 | awk '/inet/ { print $2 } ' |
      sed -e s/addr://)
    echo ${MY_IP:-"Not connected"}
}

function ii()   # Get current host related info.
{
    echo -e "\nYou are logged on ${BRed}$HOST"
    echo -e "\n${BRed}Additionnal information:$NC " ; uname -a
    echo -e "\n${BRed}Users logged on:$NC " ; w -hs |
             cut -d " " -f1 | sort | uniq
    echo -e "\n${BRed}Current date :$NC " ; date
    echo -e "\n${BRed}Machine stats :$NC " ; uptime
    echo -e "\n${BRed}Memory stats :$NC " ; free
    echo -e "\n${BRed}Diskspace :$NC " ; mydf / $HOME
    echo -e "\n${BRed}Local IP Address :$NC" ; my_ip
    echo -e "\n${BRed}Open connections :$NC "; netstat -pan --inet;
    echo
}


#-------------------------------------------------------------
# Misc utilities:
#-------------------------------------------------------------
function psgrep()
{
    expression="$1"
    ps -ef | grep $expression | sed '/grep/d'
}

function repeat()       # Repeat n times command.
{
    local i max
    max=$1; shift;
    for ((i=1; i <= max ; i++)); do  # --> C-like syntax
        eval "$@";
    done
}


function ask()          # See 'killps' for example of use.
{
    echo -n "$@" '[y/n] ' ; read ans
    case "$ans" in
        y*|Y*) return 0 ;;
        *) return 1 ;;
    esac
}

function corename()   # Get name of app that created a corefile.
{
    for file ; do
        echo -n $file : ; gdb --core=$file --batch | head -1
    done
}
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
  #PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
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
