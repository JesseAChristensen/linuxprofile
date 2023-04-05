# linuxprofile
This is my personal Linux command line customization utility.

This primarily customizes the ~/.bashrc file to add functions and aliases
to make CLI life slightly more convenient. It also includes customization
files for vim, pylint, lftp, tmux and git.

## Bash Customizations
There are too many tweaks to the bash environment to list here. Check
the `bashrc` file if you want to go crazy.

### Notable customizations
* The command prompt is colorized and displays as `<username>@<hostname>:<cwd>$`.
* The command prompt uses vi for input navigation!
* When using `cd` minor spelling errors may be corrected.
* A timeout of 10,000 seconds is set for an inactive terminal (TMOUT=10000).
* Bash completion is activated if it is installed.

### Helper functions
Most of the bash functions have an associated help message. To see the
available help messages, use the command `helpers`. Most of the helper
functions are simply notes to myself on how to execute a command.
* `helpFunctions` Display help messages for custom bash functions.
* `helpSshTunnel` Display common ssh tunneling commands.
* `helpFind` Display common find commands.
* `helpLs` Display common ls commands.
* `helpVlc` Display common VLC commands.
* `helpColors` Display color codes for the bash terminal.

### Functions
This is an incomplete list of bash functions, use the `helpers` to see more.
* `rmKnownHost <hostname>` remove a known host from the `~/.ssh/known_hosts` file.
* `ff <string>` find files in the current directory tree that have 
`<string>` in the name.
* `swap <file1> <file2>` swaps `<file1>` and `<file2>`.
* `extract <archive>` uses the appropriate extractor (tar,gzip,unzip) to
unpack the `<archive>` (based on the file's extension).
* `ii` print information about the current system.
* `psgrep` grep the output of `ps -ef` and exclude the `grep` process.

### Aliases
You can view all included aliases with some added documentation by
running the `aliases` command.
* `plz` Run the last command with `sudo` (essentially a `sudo !!`)
* `getExternalIp` Run the `~/bin/getExternalIp.py` script to discover your
external facing IP address. (Uses http://ip.42.pl.raw)
* `py310` Activate your python virtual environment in `~/py310`. Similar
aliases are available for most python versions. This requires you to have
installed the python virtual environment as such: `python -m ~/py310`.


## Installation
Run the following command in the terminal:
`./install.sh`

## ToDo:
* cleanup the py310 type aliases to just parse the home directory for
directories starting with `py` and dynamically make those aliases available.
