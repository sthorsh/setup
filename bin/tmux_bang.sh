# todo: tmux_bang.sh
# todo: ssh keys → github

tmux has-session -t s1
if [ $? != 0 ]
then
  echo "creating session..."
  tmux new-session -s s1 -n home -d
  sleep 1

  # 2nd window
  echo "creating 2nd window..."
  tmux new-window -t s1 -n fuse -c /usr/lib
  tmux split -t s1:2.1 -c /usr/lib
  tmux split -t s1:2.1 -h -c /usr/lib
  tmux select-pane -t s1:2.1
  tmux send-keys -t s1:2.1 "echo boom" C-m
  tmux send-keys -t s1:2.1 "echo bin/fuse start" C-m
  tmux send-keys -t s1:2.2 "echo /usr/lib/apace-activemq/bin/activemq start"
  tmux send-keys -t s1:2.3 "echo tail -f data/log/fuse.log" C-m
  sleep 1

  # 3rd window
  echo "creating 3rd window..."
  tmux new-window -t s1 -n tbd -c /usr/lib
  sleep 1

  # Go home
  tmux select-pane -t s1:1.1
  sleep 1

  # Start apps
  if ! pgrep -x clipit > /dev/null
    then 
      echo "starting clipit..."
      clipit > /dev/null 2>&1 &
    else echo "clipit already running..."
  fi
  sleep 1

  if ! pgrep -x guake > /dev/null
    then 
      echo "starting guake..."
      guake > /dev/null 2>&1 &
    else echo "guake already running..."
  fi
  sleep 1

  if ! pgrep -x chromium-browse > /dev/null
    then 
      echo "starting chrome..."
      chromium-browser > /dev/null 2>&1 &
    else echo "chrome already running..."
  fi

  sleep 1
  if ! pgrep -x firefox > /dev/null
    then 
      echo "starting firefox..."
      firefox > /dev/null 2>&1 &
    else echo "firefox already running..."
  fi
  sleep 1

  if ! pgrep -x slack > /dev/null 2>&1
    then 
      echo "starting slack..."
      slack > /dev/null 2>&1 &
    else echo "slack already running..."
  fi
  sleep 1

  if pgrep java --list-full | grep idea > /dev/null 2>&1
    then echo "intellij already running..."
    else 
      echo "starting intellij..."
      /bin/bash /usr/lib/idea-IC/bin/idea.sh > /dev/null 2>&1 &
  fi

  echo "all done..."

else
  echo "session s1 already exists..."
fi

# attach to session
tmux attach -t s1:1.1

