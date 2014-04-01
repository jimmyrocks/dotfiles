#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
eval `ssh-agent -s`
sudo chmod 600 $DIR/id_rsa
sudo chmod 600 $DIR/id_rsa.pub
ssh-add $DIR/id_rsa.pub
