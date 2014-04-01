#!/bin/bash

SCRIPT=$(readlink -f "$0")
BASEDIR=$(dirname "SCRIPT")
eval `ssh-agent -s`
ssh-add $BASEDIR/id_rsa
