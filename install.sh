# This will backup all the existing files then it will replace them with symlinks
# I got this idea for this from here
#    http://mirnazim.org/writings/vim-plugins-i-use/

# # BACKUP {
#
# Get some useful variables
this_host=$(hostname -f)
this_date=$(date -u '+%Y%m%d')

# Create the directories for backing up
mkdir -p  $HOME/dotfiles/backups/$this_host
mkdir -p  $HOME/dotfiles/backups/$this_host/$this_date

# Bash Files
mv $HOME/.bashrc $HOME/dotfiles/backups/$this_host/$this_date/.bashrc
mv $HOME/.bash_profile $HOME/dotfiles/backups/$this_host/$this_date/.bash_profile
#mv $HOME/.bash_alias $HOME/dotfiles/backups/$this_host/$this_date/.bash_aliases

# vim files
mv $HOME/.vimrc $HOME/dotfiles/backups/$this_host/$this_date/.vimrc
mv $HOME/.vim $HOME/dotfiles/backups/$this_host/$this_date/.vim
#
# other files
mv $HOME/.jshintrc $HOME/dotfiles/backups/$this_host/$this_date/.jshintrc
mv $HOME/.eslintrc.js $HOME/dotfiles/backups/$this_host/$this_date/.eslintrc.js
mv $HOME/.tmux.confg $HOME/dotfiles/backups/$this_host/$this_date/.tmux.conf
mv $HOME/.psqlrc $HOME/dotfiles/backups/$this_host/$this_date/.psqlrc
# }

# CREATE SYMLINKS {
#
# Bash
ln -s $HOME/dotfiles/bash/bashrc $HOME/.bashrc
#ln -s $HOME/dotfiles/bash/aliases $HOME/.bash_aliases
ln -s $HOME/dotfiles/bash/bash_profile $HOME/.bash_profile
# vim
ln -s $HOME/dotfiles/vim $HOME/.vim
ln -s $HOME/dotfiles/vim/vimrc $HOME/.vimrc
#
# other
ln -s $HOME/dotfiles/other/jshintrc $HOME/.jshintrc
ln -s $HOME/dotfiles/other/eslintrc.js $HOME/.eslintrc.js
ln -s $HOME/dotfiles/other/tmux.conf $HOME/.tmux.conf
ln -s $HOME/dotfiles/other/psqlrc.sql $HOME/.psqlrc
# }

# Run an update
sh ./update.sh
