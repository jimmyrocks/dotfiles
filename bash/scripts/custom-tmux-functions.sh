function tmux.new(){
  tmux.l new $1
}

function tmux.l(){

# List the Available Sessions (if there are any?)
  old_IFS=$IFS
  IFS=$'\n'
  COUNTER=0
  SESSIONS[0]=""
  view=$1 #Skips to a view
  session_name=$2 #Session name for new sessions
  display_only=$3 #If this is set, it will only list sessions

  # Check if tmux is running, and prompt the user to start it if it is not running
  if [[ `tmux list-sessions 2>/dev/null` == "" ]]; then
    read -r -e -p "tmux not running, would you like to start tmux? (y/N): " start_tmux
    if [ $start_tmux == "y" -o $start_tmux == "Y" ]; then
      view='new'
    else
      view='0'
    fi
  fi

  # If the view is set to 0 (no view), give the user a list of views
  if [[ -z "$view" ]]; then
    echo "╔════════════════════════════════════════════════════════════════════════════╗"
    for line in `tmux list-sessions`; do
      COUNTER=$((COUNTER+1))
      echo " "$COUNTER")" $line
      SESSIONS[$COUNTER]=`echo $line | sed 's/:.*//g'`
    done
    echo "╚════════════════════════════════════════════════════════════════════════════╝"
    if [[ -z "$display_only" ]]; then
      echo -n "Which view do you want? ('new' for new, [enter] for none): "
      read -r view
    fi
  fi

  # Create a session name
  if [[ $view == "new" ]]; then
    if [[ -z "$session_name" ]]; then
      read -r -e -p "What do you want to name this new session? " session_name
    fi
    tmux new-session -d -s "$session_name"
  elif [[ ${SESSIONS["$view"]} != "" ]]; then
    session_name="${SESSIONS["$view"]}"
  fi

  # Start the session
  if [[ -z "$display_only" ]]; then
    if [[ -n "$session_name" ]]; then
      if [ -z "$TMUX" ]; then
        tmux attach -t "$session_name"
      else
        tmux switch-client -t "$session_name"
      fi
    else
      echo 'No session selected, type tmux.l to get this menu again'
    fi
  fi
  IFS=$old_IFS
}
