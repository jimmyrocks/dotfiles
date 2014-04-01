#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
eval `ssh-agent -s`
sudo chmod 600 $DIR/id_rsa
sudo chmod 600 $DIR/id_rsa.pub
ln -s $DIR/id_rsa ~/.ssh/github_id_rsa
ln -s $DIR/id_rsa.pub ~/.ssh/github_id_rsa.pub
ssh-add ~/.ssh/github_id_rsa`
