echo -n "~/.bash_profile: "
[[ $- == *i*  ]] && echo -n 'interactive ' || echo -n 'non-interactive '
shopt -q login_shell && echo 'login' || echo 'non-login'

