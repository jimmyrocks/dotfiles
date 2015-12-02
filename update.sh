# This will go through all the vim bundles and update them

git submodule init
git submodule update --init --recursive
git submodule foreach git pull --recurse-submodules origin master

BASE_DIR=`dirname $0`

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
    apt-get -y update
    apt-get -y upgrade
    apt-get install -y vim tmux git git-core exuberant-ctags python-pip python-setuptools g++ curl libssl-dev apache2-utils make nodejs curl python-pygments
    apt-get autoremove -y

    echo '----------------'
    echo 'Setting up git'
    echo '----------------'
    git config --global user.name "Jim McAndrew"
    git config --global user.email jim@loc8.us
    git config --global credential.helper cache
    git config --global core.editor vim
    git config --global help.autocorrect 1
    git config --global color.ui true
    git config --global push.default simple

    # Get the ctags plugin and python/flake8
    echo '----------------'
    echo 'Adding vim tools'
    echo '----------------'
    pip install Distribute --upgrade
    pip install flake8 --upgrade
    mkdir -p $BASE_DIR/dotfiles/vim/bundle/tern_for_vim/node_modules
    npm --prefix $BASE_DIR/dotfiles/vim/bundle/tern_for_vim/ install

    # get node.js stuff for jshint
    echo '-------------'
    echo 'Adding nodejs tools'
    echo '-------------'
    npm install --global jshint
    npm install --global jsonlint
    npm install --global ext
    npm install --global jquery
    npm install --global http-server
    npm install --global semistandard

    echo '----------------------------'
    echo 'Adding bash completion and colorizing files'
    echo '----------------------------'
    echo 'git-completion'
    curl -LSso $BASE_DIR/dotfiles/bash/scripts/git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
    echo 'dircolors.256dark'
    curl -LSso $BASE_DIR/dotfiles/bash/scripts/dircolors.256dark https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.256dark

    echo '----------------------------'
    echo 'Adding vim syntax files'
    echo '----------------------------'
    mkdir -p $BASE_DIR/dotfiles/vim/syntax
    echo 'Python'
    curl -LSso $BASE_DIR/dotfiles/vim/syntax/python.vim https://raw.githubusercontent.com/hdima/python-syntax/master/syntax/python.vim
    echo 'Carto'
    curl -LSso $BASE_DIR/dotfiles/vim/syntax/carto.vim https://raw.githubusercontent.com/mapbox/carto/master/build/vim-carto/syntax/carto.vim
    echo 'nginx'
    curl -LSso $BASE_DIR/dotfiles/vim/syntax/nginx.vim https://raw.githubusercontent.com/vim-scripts/nginx.vim/master/syntax/nginx.vim
    echo 'semistandard'
    cat $BASE_DIR/dotfiles/vim/bundle/syntastic/syntax_checkers/javascript/standard.vim | perl -pe 's/standard/semistandard/g' > $BASE_DIR/dotfiles/vim/bundle/syntastic/syntax_checkers/javascript/semistandard.vim 

    # Set timezone
    if [ "$1" != "quick" ]; then
      echo '---------------'
      echo 'Setting timezone'
      echo '---------------'
      dpkg-reconfigure tzdata
    fi
    # Set system clock (after the timezone is set, of course)
    echo '----------------------------'
    echo 'Updating the system clock'
    echo '----------------------------'
    ntpdate pool.ntp.org
fi

echo '------------------------'
echo 'Everything is up to date'
echo '------------------------'
