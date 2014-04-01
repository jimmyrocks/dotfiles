#!/bin/bash

SCRIPT=$(readlink -f "$0")
BASEDIR=$(dirname "SCRIPT")
ssh-add $BASEDIR"/id_rsa"
