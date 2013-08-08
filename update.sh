# This will go through all the vim bundles and update them

git submodule init
git submodule update
git submodule foreach git pull origin master

OS_NAME=`uname -s`
if [ $OS_NAME = "Linux" ]; then
    # http://stackoverflow.com/questions/16302436/install-nodejs-on-ubuntu-12-10
    echo '---------------'
    echo 'Adding packages'
    echo '---------------'
    apt-get install python-software-properties
    add-apt-repository ppa:chris-lea/node.js
    add-apt-repository ppa:git-core/ppa
    echo '---------------------------'
    echo 'Updating Installed Software'
    echo '---------------------------'
    apt-get update
    apt-get upgrade

    # Install vim
    echo '--------------'
    echo 'Installing vim'
    echo '--------------'
    apt-get install vim
    echo '---------------'
    echo 'Installing tmux'
    echo '---------------'
    apt-get install tmux

    # Get the latest git
    echo '------------'
    echo 'Updating git'
    echo '------------'
    apt-get install git git-core

    # Get the ctags plugin and python/flake8
    echo '----------------'
    echo 'Adding vim tools'
    echo '----------------'
    apt-get install exuberant-ctags
    apt-get install python-pip
    apt-get install python-setuptools
    pip install Distribute
    pip install flake8 --upgrade

    # get node.js stuff for jshint
    echo '-------------'
    echo 'Adding nodejs'
    echo '-------------'
    apt-get install g++ curl libssl-dev apache2-utils
    apt-get install make nodejs
    npm install --global jshint

    # get curl
    echo '------------'
    echo 'Getting curl'
    echo '------------'
    apt-get install curl

    # Set timezone
    echo '---------------'
    echo 'Setting timezone'
    echo '---------------'
    sudo dpkg-reconfigure tzdata
fi

echo '----------------------------'
echo 'Adding bash completion files'
echo '----------------------------'
curl -Sso ~/dotfiles/bash/git-completion.bash https://raw.github.com/git/git/master/contrib/completion/scripts/git-completion.bash

echo '------------------------'
echo 'Everything is up to date'
echo '------------------------'
