# This will go through all the vim bundles and update them

git submodule init
git submodule update --init --recursive
git submodule foreach git pull --recurse-submodules origin master

BASE_DIR=$( cd $(dirname $0) ; pwd -P )

OS_NAME=`uname -s`
    echo '---------------'
    echo 'Adding packages'
    echo '---------------'
    add-apt-repository -y ppa:git-core/ppa

    # Add tmux-next if it's supported through the PPA
    # Supported versions can be found here:
    #   https://launchpad.net/~pi-rho/+archive/ubuntu/dev
    TMUX_NAME="tmux-next"
    UBUNTU_VERSION=`lsb_release -rs`
    TMUX_CMD="add-apt-repository -y ppa:pi-rho/dev"
    if [[ "$UBUNTU_VERSION" = @(18.04|18.10.1|15.04.1|17.04.1|12.04.1|14.04.1|16.04.1|17.10.1) ]] ; then
      $TMUX_CMD
      apt-get install -y software-properties-common
    else
      TMUX_NAME="tmux"
      apt-get install -y python-software-properties
    fi

    echo '---------------------------'
    echo 'Updating and Installing Software'
    echo '---------------------------'
    apt-get -y update
    #apt-get -y upgrade
    apt-get install -y vim $TMUX_NAME git exuberant-ctags python-pip \
      python-setuptools g++ curl libssl-dev apache2-utils make nodejs npm \
      python-pygments ntp python-autopep8
    apt-get autoremove -y

    # If we're using tmux-next link that to tmux
    if [ "$TMUX_NAME" != "tmux" ]; then
      rm /usr/bin/tmux
      ln -s $(which $TMUX_NAME) /usr/bin/tmux
    fi
    # update pip
    mkdir -p ~/.cache/pip
    chown -R `whoami`:`whoami` ~/.cache/pip
    pip install -U pip

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
    pip install --upgrade pip
    pip install Distribute --upgrade
    pip install flake8 --upgrade
    pip install --upgrade autopep8
    mkdir -p $BASE_DIR/vim/bundle/tern_for_vim/node_modules
    npm --prefix $BASE_DIR/vim/bundle/tern_for_vim/ install

    # get node.js stuff for jshint
    echo '-------------'
    echo 'Adding nodejs tools'
    echo '-------------'
    npm install --global jshint
    npm install --global eslint
    npm install --global typescript
    npm install --global tslint
    npm install --global jsonlint
    npm install --global ext
    npm install --global jquery
    npm install --global http-server
    npm install --global semistandard

    echo '----------------------------'
    echo 'Adding bash completion and colorizing files'
    echo '----------------------------'
    echo 'git-completion'
    curl -LSso $BASE_DIR/bash/scripts/git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
    curl -LSso $BASE_DIR/bash/scripts/git-prompt.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
    echo 'dircolors.256dark'
    curl -LSso $BASE_DIR/bash/scripts/dircolors.256dark https://raw.githubusercontent.com/seebi/dircolors-solarized/master/dircolors.256dark

    echo '----------------------------'
    echo 'Adding vim syntax files'
    echo '----------------------------'
    mkdir -p $BASE_DIR/vim/syntax
    echo 'Python'
    curl -LSso $BASE_DIR/vim/syntax/python.vim https://raw.githubusercontent.com/hdima/python-syntax/master/syntax/python.vim
    echo 'Carto'
    curl -LSso $BASE_DIR/vim/syntax/carto.vim https://raw.githubusercontent.com/mapbox/carto/master/build/vim-carto/syntax/carto.vim
    echo 'nginx'
    curl -LSso $BASE_DIR/vim/syntax/nginx.vim https://raw.githubusercontent.com/vim-scripts/nginx.vim/master/syntax/nginx.vim
    echo 'semistandard'
    cat $BASE_DIR/vim/bundle/syntastic/syntax_checkers/javascript/standard.vim | perl -pe 's/standard/semistandard/g' > $BASE_DIR/vim/bundle/syntastic/syntax_checkers/javascript/semistandard.vim 

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
    service ntp stop
    ntpd -gq
    service ntp start

echo '------------------------'
echo 'Everything is up to date'
echo '------------------------'
