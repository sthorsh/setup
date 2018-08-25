echo -n "~/.bash_profile: "
[[ $- == *i*  ]] && echo -n 'interactive ' || echo -n 'non-interactive '
shopt -q login_shell && echo 'login' || echo 'non-login'

# start clipboard manager
if ! pgrep -x "clipit" > /dev/null 
then 
  clipit & 
fi

# start terminal drop-down
if ! pgrep -x "guake" > /dev/null 2>&1
then 
  guake > /dev/null 2>&1 &
fi

source ~/.bashrc
