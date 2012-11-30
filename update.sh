# This will go through all the vim bundles and update them

git submodule foreach git pull origin master

curl -Sso ~/dotfiles/bash/git-completion.bash https://raw.github.com/git/git/master/contrib/completion/git-completion.bash
