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
    apt-get install -y python-software-properties
    add-apt-repository -y ppa:chris-lea/node.js
    add-apt-repository -y ppa:git-core/ppa

    echo '---------------------------'
    echo 'Updating and Installing Software'
    echo '---------------------------'
    apt-get update
    apt-get upgrade
    apt-get install -y vim tmux git git-core exuberant-ctags python-pip python-setuptools g++ curl libssl-dev apache2-utils make nodejs curl python-pygments

    echo '----------------'
    echo 'Setting up git'
    echo '----------------'
    git config --global user.name "Jim McAndrew"
    git config --global user.email jim@loc8.us

    # Get the ctags plugin and python/flake8
    echo '----------------'
    echo 'Adding vim tools'
    echo '----------------'
    pip install Distribute
    pip install flake8 --upgrade

    # get node.js stuff for jshint
    echo '-------------'
    echo 'Adding nodejs tools'
    echo '-------------'
    npm install --global jshint
    npm install --global ext
    npm install --global jquery

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
