# Stop if not interactive
[[ $- != *i*  ]] && return

# Opts
set -o ignoreeof
set -o noclobber
set -o notify
shopt -s globstar
shopt -s histappend

# Vars
export AMQ_HOME=/usr/lib/apache-activemq
export CHEATCOLORS=false
export EDITOR=/usr/bin/vim
export FOP_HOME="/usr/lib/fop/fop"
export FZF_DEFAULT_OPTS='--extended --height 60% --reverse --border'
export GRADLE_HOME="/opt/gradle/gradle"
export HISTCONTROL=ignoreboth
export HISTFILESIZE=100000
export HISTSIZE=100000
export HISTTIMEFORMAT="%Y-%m-%d %H:%M "
export JAVA_HOME=/usr/lib/jvm/java
export JFROG_HOME=/home/svein/jfrog/
export KAFKA_HOME=/usr/lib/kafka
export LESS='--LINE-NUMBERS --LONG-PROMPT'
export MAVEN_HOME=/usr/lib/apache-maven
export PROMPT_COMMAND="${PROMPT_COMMAND:=history -a; history -c; history -r; $PROMPT_COMMAND}"
export VISUAL=/usr/bin/vim
export ZOOKEEPER_HOME=/opt/zooinspector

# PATH
[[ ":$PATH:" != *${AMQ_HOME}/bin* ]] && export PATH=${PATH}:${AMQ_HOME}/bin
[[ ":$PATH:" != *${FOP_HOME} ]] && export PATH=${PATH}:${FOP_HOME}
[[ ":$PATH:" != *${GRADLE_HOME}/bin* ]] && export PATH=${PATH}:${GRADLE_HOME}/bin
[[ ":$PATH:" != *${JAVA_HOME}/bin* ]] && export PATH=${PATH}:${JAVA_HOME}/bin
[[ ":$PATH:" != *${KAFKA_HOME}/bin* ]] && export PATH=${PATH}:${KAFKA_HOME}/bin
[[ ":$PATH:" != *${MAVEN_HOME}/bin* ]] && export PATH=${PATH}:${MAVEN_HOME}/bin
[[ ":$PATH:" != *${ZOOKEEPER_HOME}/bin* ]] && export PATH=${PATH}:${ZOOKEEPER_HOME}/bin
export PATH="$PATH:/home/svein/.minishift/cache/oc/v3.11.0/linux"
export PATH="$PATH:/usr/share/zookeeper/bin"

# TERM
[[ -n "$DISPLAY" && "$TERM" == "xterm" ]] && export TERM=xterm-256color

# PS
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(. *\)/\1/'
}

case "$TERM" in
    xterm|xterm-color|*-256color) color_prompt=yes;;
esac
if [ "$color_prompt" != yes ]; then
    PS1='\u@\h \w \$ '
  else
    if [[ ${EUID} != 0 ]] ; then
        export PS1="\[\e[01;32m\]\u@\h \w \$(parse_git_branch)\n$\[\e[00m\] "
        #export PS1='\[\e[01;32m\]\u@\h\[\e[01;34m\][\w]\[\e[01;32m\]\$\[\e[00m\] '
        #export PS1="\[\e[02;32m\]\u@\h\[\033[34m\][\w]\[\033[33m\]\$(parse_git_branch)\[\033[32m\]$\[\e[00m\] "
        #export PS1="\[\e[06;32m\]\u@\h\[\e[01;34m\][\w]\[\033[30m\]\$(parse_git_branch)\[\033[34m\] $ \[\e[00m\]"
        #export PS1="\[\e[01;32m\]\u@\h\[\e[01;34m\] \w \[\033[33m\]\$(parse_git_branch)\[\e[00m\] $ "
    else
        PS1='\e[01;31m\h \W \$\e[00m '
    fi
fi
unset color_prompt

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
bind '"\C-]":character-search'
bind '"\C-[":character-search-backward'
bind '"\C-q":unix-filename-rubout'
bind '"\e\C-a":start-kbd-macro'
bind '"\e\C-s":end-kbd-macro'

# Readline macros
bind '"\C-x\x27":"\x27\x27\C-b"'
bind '"\C-x\"": "\"\"\C-b"'
bind '"\C-x(": "()\C-b"'
bind '"\C-x{": "{}\C-b  \C-b"'
bind '"\C-x[": "[]\C-b"'
bind '"\C-x:": "::\C-b"'
bind '"\C-xp": "PATH=${PATH}\e\C-e\C-a\ef\C-f"'
bind '"\C-xq": "\eb\"\ef\" "'
bind '"\C-xu":"\eb\eu "'

# Aliases
alias ansible-playbook="ansible-playbook -e ansible_python_interpreter=/usr/bin/python"
alias awkde="cat ~/doc/awk/exp.txt"
alias awkdv="awk --dump-variables=$(tty) ''"
alias awkdf="awk 'BEGIN { for(key in FUNCTAB) print FUNCTAB[key] }' | sort"
alias cs="cheat"
alias datetime="date '+%Y-%m-%dT%H:%M:%S'"
alias egrep='egrep --ignore-case --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --ignore-case --color=auto'
alias gta='cd /usr/lib/apache-activemq/'
alias gtf='cd /usr/lib/jboss-fuse/'
alias ij='/bin/bash /usr/lib/idea-IC/bin/idea.sh > /dev/null 2>&1 &'
alias jobs="jobs -l"
alias kc='kafkacat'
alias l='ls -lF --color=auto --group-directories-first'
alias la='ls -alF --color=auto --group-directories-first'
alias ld='ls -dl --color=auto --group-directories-first  .[!.]*'
alias manopt='manly'
alias mount='mount | column -t'
alias mvnf='mvn clean install -Pfindbugs,checkstyle'
alias mvnl='mvn clean install -Dmaven.test.skip=true'
alias path='echo -e ${PATH//:/"\n"}'
alias pip="pip3.7"
alias postman='/opt/Postman/Postman > /dev/null 2>&1 &'
alias ps='ps -efj --header'
alias soapui="/opt/SoapUI-5.5.0/bin/soapui.sh > /dev/null 2>&1 &"
alias sqldeveloper='/bin/bash /usr/lib/sqldeveloper/sqldeveloper.sh > /dev/null 2>&1 &'
alias squirrelsql='/usr/lib/squirrelsql/squirrel-sql.sh &'
alias type='type -a'
alias x='exit'
alias xsc='xclip -selection clipboard'

# Source startup files
[ -f /usr/share/autojump/autojump.sh ] && source /usr/share/autojump/autojump.sh
[ -f ~/bin/func_cd ] && source ~/bin/func_cd
[ -f ~/bin/completion/mvn.sh ] && source ~/bin/completion/mvn.sh
[ -f ~/bin/completion/tmux.sh ] && source ~/bin/completion/tmux.sh
[ -f ~/bin/completion/cheat.bash ] && source ~/bin/completion/cheat.bash
[ -f ~/bin/completion/gradle.bash ] && source ~/bin/completion/gradle.bash
[ -f ~/bin/completion/minikube.bash ] && source ~/bin/completion/minikube.bash
[ -f ~/bin/completion/minishift.bash ] && source ~/bin/completion/minishift.bash
[ -f ~/bin/completion/oc.bash ] && source ~/bin/completion/oc.bash
[ -f ~/bin/completion/vagrant ] && source ~/bin/completion/vagrant
[ -f ~/bin/completion/kafka.bash ] && source ~/bin/completion/kafka.bash

# Start programs
! pgrep ssh-agent > /dev/null 2>&1 && ( eval "$(ssh-agent -s)"; ssh-add ~/.ssh/id_rsa )
[[ -d $AMQ_HOME ]] && ! activemq status >/dev/null && activemq start >/dev/null 
which clipit && ! pgrep clipit >/dev/null 2>&1 && ( clipit & )

source <(kubeadm completion bash)
source <(kubectl completion bash)
source <(helm completion bash)

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
#export SDKMAN_DIR="/home/svein/.sdkman"
#[[ -s "/home/svein/.sdkman/bin/sdkman-init.sh" ]] && source "/home/svein/.sdkman/bin/sdkman-init.sh"
