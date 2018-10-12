# If not interactive, return
case $- in
    *i*) ;;
      *) return;;
esac

# Log on entry
shopt -q login_shell && echo -n 'login ' || echo -n 'ikke-login '
[[ $- == *i*  ]] && echo -n 'interaktivt ' || echo -n 'ikke-interaktivt '
echo "→  ~/.bashrc"

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

# avoid duplicate PATH entries
add_to_path () {
  if ! echo $PATH | /bin/grep -Eq "(^|:)$1($|:)"; then
    export PATH=$PATH:$1
  else
    echo "path already contains $1 - not added"
  fi
}

# Bindings
bind -r '\C-s'
bind -r '\C-q'
bind 'tab:menu-complete'
bind '"\C-q":unix-filename-rubout'
bind '"\e\C-w":glob-expand-word'
bind 'set show-all-if-ambiguous on'
bind 'set menu-complete-display-prefix on'

# Disable stty xon/xoff flow control
stty -ixon
# Disable stty start/stop characters
stty -ixoff

# remap capslock to ctrl
#setxkbmap -option ctrl:nocaps
# disable ctrl
#xmodmap -e 'keycode 37 = NoSymbol'

# Options
set -o ignoreeof
set -o noclobber
set -o notify
shopt -s globstar
shopt -s histappend              

# Aliases
alias gradle="/opt/gradle/bin/gradle"
alias grep='grep --color=auto'
alias gta='cd /usr/lib/apache-activemq/'
alias gtf='cd /usr/lib/jboss-fuse/'
alias ij='/bin/bash /usr/lib/idea-IC/bin/idea.sh > /dev/null 2>&1 &'
alias l='ls -lF --color=auto --group-directories-first'
alias la='ls -alF --color=auto --group-directories-first'
alias mvnf='mvn clean install -Pfindbugs,checkstyle'
alias mvnl='mvn clean install -Dmaven.test.skip=true'
alias path='echo -e ${PATH//:/"\n"}' 
alias ps='ps -ef'
alias sqldeveloper='/bin/bash /usr/lib/sqldeveloper/sqldeveloper.sh > /dev/null 2>&1 &'
alias squirrelsql='/usr/lib/squirrelsql/squirrel-sql.sh &'
alias x='exit'
 
# Variables
export EDITOR=/usr/bin/vim
export HISTSIZE=5000
export HISTFILESIZE=10000
export HISTCONTROL=ignoreboth
export LESS='--LINE-NUMBERS --LONG-PROMPT'
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
export VISUAL=/usr/bin/vim
export JAVA_HOME=/usr/lib/jvm/java
add_to_path ${JAVA_HOME}/bin/
export MAVEN_HOME=/usr/lib/apache-maven
add_to_path ${MAVEN_HOME}/bin/
export FZF_DEFAULT_OPTS='--extended --height 60% --reverse --border'

# Autojump
[ -f /usr/share/autojump/autojump.sh ] && source /usr/share/autojump/autojump.sh
# Fuzzy fnder
# [ -f ~/.fzf.bash ] && source ~/.fzf.bash
# Mvn completion
[ -f ~/bin/bash_completion_mvn.sh ] && source ~/bin/bash_completion_mvn.sh
# Tmux completion
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

