# If ! interactive, return
[[ $- != *i*  ]] && return

# Log combination of states
shopt -q login_shell && echo -n 'login ' || echo -n 'non-login '
[[ $- == *i*  ]] && echo -n 'interactive ' || echo -n 'non-interactive '
echo "→  ~/.bashrc"

# Bindings bash
bind '"\C-q":unix-filename-rubout'
bind '"\e\C-w":glob-expand-word'
bind 'tab:menu-complete'
bind 'set menu-complete-display-prefix on'
bind 'set show-all-if-ambiguous on'
bind Space:magic-space

# Bindings tty
stty -ixon -ixoff

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
alias jobs="jobs -l"
alias l='ls -lF --color=auto --group-directories-first'
alias la='ls -alF --color=auto --group-directories-first'
alias mvnf='mvn clean install -Pfindbugs,checkstyle'
alias mvnl='mvn clean install -Dmaven.test.skip=true'
alias path='echo -e ${PATH//:/"\n"}' 
alias postman='/opt/Postman/Postman > /dev/null 2>&1 &'
alias ps='ps -ef'
alias soapui="/opt/SoapUI-5.5.0/bin/soapui.sh > /dev/null 2>&1 &"
alias sqldeveloper='/bin/bash /usr/lib/sqldeveloper/sqldeveloper.sh > /dev/null 2>&1 &'
alias squirrelsql='/usr/lib/squirrelsql/squirrel-sql.sh &'
alias x='exit'

# Params/variables
export EDITOR=/usr/bin/vim
export HISTSIZE=5000
export HISTFILESIZE=10000
export HISTCONTROL=ignoreboth
export LESS='--LINE-NUMBERS --LONG-PROMPT'
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
export VISUAL=/usr/bin/vim
export JAVA_HOME=/usr/lib/jvm/java
export MAVEN_HOME=/usr/lib/apache-maven
export FZF_DEFAULT_OPTS='--extended --height 60% --reverse --border'

# Functions
add_to_path () {
  if ! echo $PATH | /bin/grep -Eq "(^|:)$1($|:)"; then
    export PATH=$PATH:$1
  else
    echo "path already contains $1 - not added"
  fi
}

# Define PATH
add_to_path ${JAVA_HOME}/bin/
add_to_path ${MAVEN_HOME}/bin/

# Define PS1
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

# Define TERM (for vim)
if [ -n "$DISPLAY" -a "$TERM" == "xterm"  ]; then
  export TERM=xterm-256color
fi

# Autojump
[ -f /usr/share/autojump/autojump.sh ] && source /usr/share/autojump/autojump.sh

# Bash completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Mvn completion
[ -f ~/bin/bash_completion_mvn.sh ] && source ~/bin/bash_completion_mvn.sh

# Tmux completion
[ -f ~/bin/bash_completion_tmux.sh ] && source ~/bin/bash_completion_tmux.sh

# Start ssh
if pgrep ssh-agent > /dev/null 2>&1
then
  echo "ssh-agent running..."
else
  echo "starting ssh-agent..."
  eval "$(ssh-agent -s)"
  ssh-add ~/.ssh/id_rsa_git
fi

# Start clipit
if pgrep clipit > /dev/null 2>&1
then
  echo "clipit running..."
else
  echo "starting clipit.."
  clipit &
fi

# Start activemq
if /usr/lib/apache-activemq/bin/activemq status > /dev/null 2>&1
then
  echo "activemq running..."
else
  /usr/lib/apache-activemq/bin/activemq start
fi

