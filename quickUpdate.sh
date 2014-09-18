#!/usr/bin/env bash
CWD=$(pwd)
thisScript="$(basename "$(test -L "$0" && readlink "$0" || echo "$0")")"
thisDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
thisUserGroup=`/bin/ls -la $thisDir/$thisScript | awk '{print $3 ":" $4}'`
shopt -s expand_aliases
source $thisDir"/bash/scripts/custom-git-functions.sh"
#echo 'thisScript'
#echo $thisScript
#echo 'thisDir'
#echo $thisDir
#echo 'thisUserGroup'
#echo $thisUserGroup
cd $thisDir
git.key && git.loop && git.pp && sudo chown -R $thisUserGroup $thisDir && sudo bash update.sh && git.loop && git.pp
cd $CWD
