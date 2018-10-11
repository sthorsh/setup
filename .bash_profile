shopt -q login_shell && echo -n 'login ' || echo -n 'ikke-login '
[[ $- == *i*  ]] && echo -n 'interaktivt ' || echo -n 'ikke-interaktivt '
echo "→  ~/.bash_profile"

source ~/.bashrc

