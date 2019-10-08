#!/bin/bash

# These are helpers I've added to remind me that I'm doing something wrong

function ssh {
    if `echo $1 | grep -E "@|^-" 1>/dev/null 2>&1`; then
       `which ssh` $*
    else
        echo "You did not include a username"
        echo -n "Did you mean: ssh $USER@$1 (y/n): "
        read yn
        if [[ $yn == "N" || $yn == "n" ]]; then
            echo -n "Which username did you intend to use?: "
            read new_un
            echo "ssh" $new_un@$*
            `which ssh` $new_un@$*
        else
            `which ssh` $USER@$*
        fi
    fi
}

function sftp {
    if `echo $1 | grep -E "@|^-" 1>/dev/null 2>&1`; then
       `which sftp` $*
    else
        echo "You did not include a username"
        echo -n "Did you mean: sftp $USER@$1 (y/n): "
        read yn
        if [[ $yn == "N" || $yn == "n" ]]; then
            echo -n "Which username did you intend to use?: "
            read new_un
            echo "sftp" $new_un@$1
            `which sftp` $new_un@$1
        else
            `which sftp` $USER@$1
        fi
    fi
}

function vf {
    params=$@
    echo -n "Did you mean: 'cd $params'? ((y)/n): "
    read yn
    if [[ $yn == "N" || $yn == "n" ]]; then
        echo "ok"
    else
        cd $params
    fi
}

function gut {
    params=$@
    echo -n "Did you mean: 'git $params'? ((y)/n): "
    read yn
    if [[ $yn == "N" || $yn == "n" ]]; then
        echo "ok"
    else
        git $params
    fi
}

function serveHttp {
  if [[ $1 == "" ]]; then
    port=8000
  else
    port=$1
  fi

  if hash http-server 2>/dev/null; then
    http-server "`pwd`" -p $port
  else
    python -m SimpleHTTPServer $port
  fi
  thisip
}

function thisip {
  # ifconfig | awk -v RS="\n\n" '{ for (i=1; i<=NF; i++) if ($i == "inet" && $(i+1) ~ /^addr:/) address = substr($(i+1), 6); if (address != "127.0.0.1") printf "\033[34m%s\033[0m\t\033[33m%s\033[0m\n", $1, address }'
  ip address | grep eth0 | grep inet | perl -pe 's/.+?inet\s(.+?)\/.+/\1/g'
}

function resetip {
  sudo /etc/init.d/networking restart
  thisip
}
