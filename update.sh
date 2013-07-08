# This will go through all the vim bundles and update them

git submodule update --init --recursive
git submodule update

curl -Sso ~/dotfiles/bash/git-completion.bash https://raw.github.com/git/git/master/contrib/completion/scripts/git-completion.bash

OS_NAME=`uname -s`
if [ $OS_NAME = "Linux" ]; then
    sudo apt-get install exuberant-ctags
    sudo apt-get install python-pip
    sudo pip install flake8
    sudo pip install flake8 --upgrade
    sudo apt-get install node
    npm install --global jshint
fi
