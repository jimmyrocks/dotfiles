# This will backup all the existing files then it will replace them with symlinks
# I got this idea for this from here
#    http://mirnazim.org/writings/vim-plugins-i-use/

# # BACKUP {
#
# Get some useful variables
this_host=$(hostname -f)
this_date=$(date -u '+%Y%m%d')

# Create the directories for backing up
mkdir -p  ~/dotfiles/backups/$this_host
mkdir -p  ~/dotfiles/backups/$this_host/$this_date

# Bash Files
mv ~/.bashrc ~/dotfiles/backups/$this_host/$this_date/.bashrc
mv ~/.bash_profile ~/dotfiles/backups/$this_host/$this_date/.bash_profile
mv ~/.bash_alias ~/dotfiles/backups/$this_host/$this_date/.bash_aliases

# vim files
mv ~/.vimrc ~/dotfiles/backups/$this_host/$this_date/.vimrc
mv ~/.vim ~/dotfiles/backups/$this_host/$this_date/.vim
#
# }

# CREATE SYMLINKS {
#
# Bash
ln -s ~/dotfiles/bash/bashrc ~/.bashrc
ln -s ~/dotfiles/bash/aliases ~/.bash_aliases
ln -s ~/dotfiles/bash/bash_profile ~/.bash_profile
# vim
ln -s ~/dotfiles/vim ~/.vim
ln -s ~/dotfiles/vim/vimrc ~/.vimrc
#
# }
