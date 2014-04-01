#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
eval `ssh-agent -s`
ssh-add $DIR/id_rsa
