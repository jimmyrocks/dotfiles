# This will go through all the vim bundles and update them

git submodule foreach git pull origin master

curl -Sso ~/dotfiles/bash/git-completion.bash https://raw.github.com/git/git/master/contrib/completion/git-completion.bash
curl -Sso ~/dotfiles/vim/colors/solarized.vim https://raw.github.com/altercation/vim-colors-solarized/master/colors/solarized.vim
