# Stop if not interactive
[[ $- != *i*  ]] && return

# Disable ^S ^Q
stty -ixon -ixoff

# Readline vars 
bind 'set colored-completion-prefix on'
bind 'set completion-display-width 0'
bind 'set completion-query-items 75'
bind 'set menu-complete-display-prefix on'
bind 'set show-all-if-ambiguous on'

# Readline cmds
bind '"\e\C-f":shell-forward-word'
bind '"\e\C-b":shell-backward-word'
bind '"\C-[":character-search-backward'
bind '"\e\C-w":glob-expand-word'
bind '"\C-q":unix-filename-rubout'
bind '"\e\C-m":start-kbd-macro'
bind '"\em":end-kbd-macro'
bind 'space:magic-space'

# Readline macros
bind '"\C-x\x27":"\x27\x27\C-b"'
bind '"\C-x\"": "\"\"\C-b"'
bind '"\C-x(": "()\C-b"'
bind '"\C-x{": "{}\C-b  \C-b"'
bind '"\C-x[": "[]\C-b"'
bind '"\C-xp": "PATH=${PATH}\e\C-e\C-a\ef\C-f"'
bind '"\C-xq": "\eb\"\ef\" "'
bind '"\C-xu":"\eb\eu "'

# Opts
set -o ignoreeof
set -o noclobber
set -o notify
shopt -s globstar
shopt -s histappend

# Vars
export AMQ_HOME=/usr/lib/apache-activemq
export EDITOR=/usr/bin/vim
export FOP_HOME="/usr/lib/fop/fop"
export FZF_DEFAULT_OPTS='--extended --height 60% --reverse --border'
export HISTCONTROL=ignoreboth
export HISTFILESIZE=100000
export HISTSIZE=100000
export HISTTIMEFORMAT="%Y-%m-%d %H:%M "
export JAVA_HOME=/usr/lib/jvm/java
export LESS='--LINE-NUMBERS --LONG-PROMPT'
export MAVEN_HOME=/usr/lib/apache-maven
export PROMPT_COMMAND="${PROMPT_COMMAND:=history -a; history -c; history -r; $PROMPT_COMMAND}"
export VISUAL=/usr/bin/vim

# PATH
[[ ":$PATH:" != *${AMQ_HOME}/bin* ]] && export PATH=${PATH}:${AMQ_HOME}/bin
[[ ":$PATH:" != *${FOP_HOME} ]] && export PATH=${PATH}:${FOP_HOME}
[[ ":$PATH:" != *${JAVA_HOME}/bin* ]] && export PATH=${PATH}:${JAVA_HOME}/bin
[[ ":$PATH:" != *${MAVEN_HOME}/bin* ]] && export PATH=${PATH}:${MAVEN_HOME}/bin

# TERM
[[ -n "$DISPLAY" && "$TERM" == "xterm" ]] && export TERM=xterm-256color

# PS
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

# Aliases
alias awkde="cat ~/doc/awk/exp.txt"
alias awkdv="awk --dump-variables=$(tty) ''"
alias awkdf="awk 'BEGIN { for(key in FUNCTAB) print FUNCTAB[key] }' | sort"
alias fgrep='fgrep --color=auto'
alias gradle="/opt/gradle/bin/gradle"
alias grep='grep --ignore-case --color=auto'
alias gta='cd /usr/lib/apache-activemq/'
alias gtf='cd /usr/lib/jboss-fuse/'
alias ij='/bin/bash /usr/lib/idea-IC/bin/idea.sh > /dev/null 2>&1 &'
alias jobs="jobs -l"
alias l='ls -lF --color=auto --group-directories-first'
alias la='ls -alF --color=auto --group-directories-first'
alias ld='ls -dl --color=auto --group-directories-first  .[!.]*'
alias mount='mount | column -t'
alias mvnf='mvn clean install -Pfindbugs,checkstyle'
alias mvnl='mvn clean install -Dmaven.test.skip=true'
alias path='echo -e ${PATH//:/"\n"}'
alias postman='/opt/Postman/Postman > /dev/null 2>&1 &'
alias ps='ps -efj --header'
alias sed='sed -r'
alias soapui="/opt/SoapUI-5.5.0/bin/soapui.sh > /dev/null 2>&1 &"
alias sqldeveloper='/bin/bash /usr/lib/sqldeveloper/sqldeveloper.sh > /dev/null 2>&1 &'
alias squirrelsql='/usr/lib/squirrelsql/squirrel-sql.sh &'
alias type='type -a'
alias x='exit'
alias xsc='xclip -selection clipboard'

# Source startup files
[ -f /usr/share/autojump/autojump.sh ] && source /usr/share/autojump/autojump.sh
[ -f ~/bin/bash_completion_mvn.sh ] && source ~/bin/bash_completion_mvn.sh
[ -f ~/bin/bash_completion_tmux.sh ] && source ~/bin/bash_completion_tmux.sh

# Start programs
! pgrep ssh-agent > /dev/null 2>&1 && ( eval "$(ssh-agent -s)"; ssh-add ~/.ssh/id_rsa_git )
[[ -d $AMQ_HOME ]] && ! activemq status >/dev/null && activemq start >/dev/null 
! pgrep clipit >/dev/null 2>&1 && ( clipit & )

