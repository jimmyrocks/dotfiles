function tmux.new(){
  tmux.l new $1
}

function tmux.l(){

# List the Available Sessions (if there are any?)
  IFS=$'\n'
  COUNTER=0
  SESSIONS[0]=""
  view=$1
  session_name=$2

  if [[ `tmux list-sessions 2>/dev/null` == "" ]]; then
    read -r -e -p "tmux not running, would you like to start tmux? (y/N): " start_tmux
    if [ $start_tmux == "y" -o $start_tmux == "Y" ]; then
      view='new'
    else
      view='0'
    fi
  fi
  if [[ -z "$view" ]]; then
    echo "╔════════════════════════════════════════════════════════════════════════════╗"
    for line in `tmux list-sessions`; do
      COUNTER=$((COUNTER+1))
      echo " "$COUNTER")" $line
      SESSIONS[$COUNTER]=`echo $line | sed 's/:.*//g'`
    done
    echo "╚════════════════════════════════════════════════════════════════════════════╝"
    echo -n "Which view do you want? ('new' for new, [enter] for none): "
    read -r view
  else
    for line in `tmux list-sessions`; do
      COUNTER=$((COUNTER+1))
      SESSIONS[$COUNTER]=`echo $line | sed 's/:.*//g'`
    done
  fi

  if [[ $view == "new" ]]; then
    if [[ -z "session_name" ]]; then
      read -r -e -p "What do you want to name this new session? " session_name
    fi
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
