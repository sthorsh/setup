# todo: /usr/lib -> /usr/lib/jboss/fuse

tmux has-session -t s1
if [ $? != 0 ]
then
  echo "creating session and 1st window..."
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
  echo "starting clipit..."
  if ! pgrep -x clipit
    then clipit > /dev/null 2>&1 &
  fi
  sleep 1

  echo "starting guake..."
  if ! pgrep -x guake
    then 
      guake > /dev/null 2>&1 &
  fi
  sleep 1

  echo "starting chrome..."
  if ! pgrep -x chromium-browser
    then 
      chromium-browser > /dev/null 2>&1 &
  fi

  sleep 1
  echo "starting firefox..."
  if ! pgrep -x firefox
    then
      firefox > /dev/null 2>&1 &
  fi
  echo "all done..."

else
  echo "session s1 already exists..."
fi
tmux attach -t s1:1.1

