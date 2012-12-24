#!/bin/bash

# These are helpers I've added to remind me that I'm doing something wrong

function ssh {
    if `echo $1 | grep "@|^-" 1>/dev/null 2>1`; then
       `which ssh` $1
    else
        echo "You did not include a username"
        echo -n "Did you mean: ssh $USER@$1 (y/n): "
        read yn
        if [[ $yn == "N" || $yn == "n" ]]; then
            echo -n "Which username did you intend to use?: "
            read new_un
            echo "ssh" $new_un@$1
            `which ssh` $new_un@$1
        else
            `which ssh` $USER@$1
        fi
    fi
}

function sftp {
    if `echo $1 | grep @ 1>/dev/null 2>1`; then
       `which sftp` $1
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
    params=$1
    echo -n "Did you mean: 'cd $params'? ((y)/n): "
    read yn
    if [[ $yn == "N" || $yn == "n" ]]; then
        echo "ok"
    else
        cd $params
    fi
}

