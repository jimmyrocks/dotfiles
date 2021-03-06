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
sudo echo "**** Quick Update ***"
cd $thisDir
if [ -z "`ssh-add -l 2> /dev/null`" ]; then
  echo `ssh-add -l 2> /dev/null`
  git.key
fi
git.loop && git.pp && sudo chown -R $thisUserGroup $thisDir && sudo bash update.sh quick && git.quickloop && git.pp
cd $CWD
