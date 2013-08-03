# This will go through all the vim bundles and update them

git submodule update --init --recursive
git submodule update

OS_NAME=`uname -s`
if [ $OS_NAME = "Linux" ]; then
    # http://stackoverflow.com/questions/16302436/install-nodejs-on-ubuntu-12-10
    sudo apt-get install python-software-properties
    sudo add-apt-repository ppa:chris-lea/node.js
    sudo apt-get update

    # Install vim
    sudo apt-get install vim
    sudo apt-get install tmux

    # Get the ctags plugin and python/flake8
    sudo apt-get install exuberant-ctags
    sudo apt-get install python-pip
    sudo apt-get install python-setuptools
    sudo pip install Distribute
    sudo pip install flake8 --upgrade

    # get node.js stuff for jshint
    sudo apt-get install g++ curl libssl-dev apache2-utils
    sudo apt-get -f install make nodejs npm
    sudo npm install --global jshint

    # get curl
    sudo apt-get install curl
fi

curl -Sso ~/dotfiles/bash/git-completion.bash https://raw.github.com/git/git/master/contrib/completion/scripts/git-completion.bash
