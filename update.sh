# This will go through all the vim bundles and update them

git submodule update --init --recursive

curl -Sso ~/dotfiles/bash/git-completion.bash https://raw.github.com/git/git/master/contrib/completion/scripts/git-completion.bash

OS_NAME=`uname -s`
if [ $OS_NAME = "Linux" ]; then
    sudo apt-get install exuberant-ctags
    sudo pip install flake8
fi
