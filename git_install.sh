if [ ! -d "$HOME/.ssh/github_ssh/" ]; then
  git clone ssh://jimmyrocks@ssh.loc8.us/home/jimmyrocks/private/github_ssh.git $HOME/.ssh/github_ssh/
fi
git --git-dir=$HOME/.ssh/github_ssh/.git pull
bash $HOME/.ssh/github_ssh/add_ssh.sh
