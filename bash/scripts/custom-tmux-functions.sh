function tmux.l(){

# List the Available Sessions (if there are any?)
  IFS=$'\n'
  COUNTER=0
  SESSIONS[0]=""

  if [[ `tmux list-sessions 2>/dev/null` == "" ]]; then
    read -r -e -p "tmux not running, would you like to start tmux? (y/N): " start_tmux
    if [ $start_tmux == "y" -o $start_tmux == "Y" ]; then
      view='new'
    else
      view='0'
    fi
  else
    echo "╔════════════════════════════════════════════════════════════════════════════╗"
    for line in `tmux list-sessions`; do
      COUNTER=$((COUNTER+1))
      echo " "$COUNTER")" $line
      SESSIONS[$COUNTER]=`echo $line | sed 's/:.*//g'`
    done
    echo "╚════════════════════════════════════════════════════════════════════════════╝"
    echo -n "Which view do you want? ('new' for new, [enter] for none): "
    read -r view
  fi

  if [[ $view == "new" ]]; then
    read -r -e -p "What do you want to name this new session? " session_name
    tmux new-session -s $session_name
  elif [[ ${SESSIONS["$view"]} != "" ]]; then
    if [ -z "$TMUX" ]; then
      tmux attach -t ${SESSIONS["$view"]}
    else
      tmux switch-client -t ${SESSIONS["$view"]}
    fi
  else
    echo 'No session selected, type tmux.l to get this menu again'
  fi
}
