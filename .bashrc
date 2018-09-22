# If not interactive, return
case $- in
    *i*) ;;
      *) return;;
esac

# Log on entry
echo -n "~/.bashrc: "
[[ $- == *i*  ]] && echo -n 'interactive ' || echo -n 'non-interactive '
shopt -q login_shell && echo 'login shell' || echo 'non-login shell'

# avoid duplicate PATH entries
add_to_path () {
  if ! echo $PATH | /bin/grep -Eq "(^|:)$1($|:)"; then
    export PATH=$PATH:$1
  else
    echo "path already contains $1 - not added"
  fi
}

# if term supports it, use prompt with colors
# $ tree /lib/terminfo will show all terminals
case "$TERM" in
    xterm|xterm-color|*-256color) color_prompt=yes;;
esac
if [ "$color_prompt" != yes ]; then
    PS1='\u@\h \w \$ '
  else
    if [[ ${EUID} != 0 ]] ; then
        PS1='\[\e[01;32m\]\u@\h\[\e[01;34m\][\w]\[\e[01;32m\]\$\[\e[00m\] '
    else
        PS1='\e[01;31m\h \W \$\e[00m '
    fi
fi
unset color_prompt

# vim needs this
if [ -n "$DISPLAY" -a "$TERM" == "xterm"  ]; then
  export TERM=xterm-256color
fi

# programmable completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# options
set -o noclobber
set -o ignoreeof
shopt -s globstar
shopt -s histappend              

# editor of choice
export EDITOR=/usr/bin/vim
# list in memory
export HISTSIZE=5000
# file on disk
export HISTFILESIZE=10000
# ignore duplicate lines or lines starting with space
export HISTCONTROL=ignoreboth
# improved less
export LESS='--LINE-NUMBERS --LONG-PROMPT'
# on each cmd append to history file, clear history list, read history file
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
# visual editor of choice
export VISUAL=/usr/bin/vim
# in /opt|usr|usr/java|usr/lib|usr/lib/jvm|usr/local|usr/local/java/
# create java home e.g /java-8-oracle/ or jdk-8u151-linux-x64/
# create soft link to java home e.g /opt/java → /opt/java-8-oracle/
export JAVA_HOME=/usr/lib/jvm/java
add_to_path ${JAVA_HOME}/bin/
export MAVEN_HOME=/usr/lib/apache-maven
add_to_path ${MAVEN_HOME}/bin/
# command line fuzzy finder fzf
export FZF_DEFAULT_OPTS='--extended --height 60% --reverse --border'

# aliases
alias gradle="/opt/gradle/bin/gradle"
alias grep='grep --color=auto'
alias gtf='cd /usr/lib/jboss-fuse/'
alias gtm='cd /usr/lib/apache-activemq/'
alias ij='/bin/bash /usr/lib/idea-IC/bin/idea.sh > /dev/null 2>&1 &'
alias l='ls -lF --color=auto --group-directories-first'
alias la='ls -alF --color=auto --group-directories-first'
alias ls='ls --color=auto --group-directories-first'
alias mci='mvn clean install'
alias mcifc='mvn clean install -Pfindbugs,checkstyle'
alias mcist='mvn clean install -Dmaven.test.skip=true'
alias onboot="~/bin/tmux_onboot.sh"
alias p='echo -e ${PATH//:/"\n"}' 
alias ps='ps -ef'
alias sqldeveloper='/bin/bash /usr/lib/sqldeveloper/sqldeveloper.sh > /dev/null 2>&1 &'
alias squirrelsql='/usr/lib/squirrelsql/squirrel-sql.sh &'
alias x='exit'
 
# remove binding to stty stop
bind -r '\C-s'
# remove binding to stty start
bind -r '\C-q'
# bind to readline function
bind 'tab:menu-complete'
bind '"\C-q":unix-filename-rubout'
bind '"\e\C-w":tilde-expand'
bind '"\e\C-r":glob-expand-word'
# set readline variable 
bind 'set show-all-if-ambiguous on'
# set readline variable
bind 'set menu-complete-display-prefix on'

# disable stty xon/xoff flow control
stty -ixon
# disable stty start/stop characters
stty -ixoff

# remap capslock to ctrl
#setxkbmap -option ctrl:nocaps
# disable ctrl
#xmodmap -e 'keycode 37 = NoSymbol'

# autojump
[ -f /usr/share/autojump/autojump.sh ] && source /usr/share/autojump/autojump.sh
# fuzzy fnder
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
# mvn completion
[ -f ~/bin/bash_completion_mvn.sh ] && source ~/bin/bash_completion_mvn.sh
# tmux completion
[ -f ~/bin/bash_completion_tmux.sh ] && source ~/bin/bash_completion_tmux.sh

# Make sure clipit is running
# if ! pgrep -x clipit > /dev/null
# then 
#   echo "starting clipit..."
#   clipit > /dev/null 2>&1 &
# else echo "clipit already running..."
# fi
# 
# # Make sure guake is running
# if ! pgrep -x guake > /dev/null
# then 
#   echo "starting guake..."
#     guake > /dev/null 2>&1 &
#   else echo "guake already running..."
# fi

