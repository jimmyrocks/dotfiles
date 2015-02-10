# git functions
    function __git_remote_branch () {
      echo 'origin' `git branch | sed -n '/\* /s///p'`
    }

    function __git_commit_file () {
      git add $1
      _basefile=$(basename $1)
      echo -e -n "What do you want your comment to be? (default: $__bash_green_on_black\"Update $_basefile\"$__bash_normal): "
      read -r -e comment
      if [[ $comment == "" ]]; then
        comment="Update $_basefile"
      fi
      git commit -m "$comment"
    }

    function git.loop () {
      git_dir=`git rev-parse --show-toplevel`
      git_files=`git status --porcelain | grep '^[ M]M ' | sed -e 's/^[ M]M\s//g'`
      echo -e $__bash_yellow"╔════════════════════════════════════════════════════════════════════════════╗"$__bash_normal
      git status
      echo -e $__bash_yellow"╚════════════════════════════════════════════════════════════════════════════╝"$__bash_normal
      for git_file in $git_files; do
        echo -e $__bash_yellow"╔════════════════════════════════════════════════════════════════════════════╗"$__bash_normal
          echo -e -n "Add the file? (y/N/d): $__bash_green_on_black$git_dir/$git_file$__bash_normal: "
          read -r -e char
          if [ $char == "d" -o $char == "D" ]; then
            git.adc $git_dir'/'$git_file
          fi
          if [ $char == "y" -o $char == "Y" ]; then
            __git_commit_file $git_dir'/'$git_file
          fi
      done
    }

    function git.quickloop () {
      git_dir=`git rev-parse --show-toplevel`
      git_files=`git status --porcelain | grep '^[ M]M ' | sed -e 's/^[ M]M\s//g'`
      for git_file in $git_files; do
        git add $git_dir"/"$git_file
        comment="Update $git_file"
        if [ -n "$1" ]; then
          comment=$1": "$comment
        fi
        git commit -m "$comment"
      done
    }


    function git.adc () {
      echo -e $__bash_yellow"╔════════════════════════════════════════════════════════════════════════════╗"$__bash_normal
      echo -e $__bash_cyan"Diff on $1"$__bash_normal
      echo -e $__bash_yellow"╚════════════════════════════════════════════════════════════════════════════╝"$__bash_normal
      git diff $1
      read -r -e -p "Do you still want to commit this file? (y/N): " yn
      if [ $yn == "y" -o $yn == "Y" ]; then
        __git_commit_file $1
      fi
    }

    function git.acm () {
      git add $1
      git commit -m "$2";
    }

    function git.type () {
      # this is useful for when you would like to get a list of all files that have been modified, in order to edit/remove/commit them
      git status | grep "\s*$1:" | perl -p -e "s/\s+?$1:\s+?//g" | perl -p -e "s/\n//g"
    }

    function git.pp () {
      # pulls and pushes git branch
      if [ -z "`ssh-add -l 2> /dev/null`" ]; then
        eval $(ssh-agent) > /dev/null
        ssh-add $HOME/.ssh/github_ssh/id_rsa
      fi
      git pull `__git_remote_branch`
      git push `__git_remote_branch`
    }


# git aliases
    alias git.a='git add'
    alias git.a.='git add .'
    alias git.ps='git push `__git_remote_branch`'
    alias git.pl='git pull `__git_remote_branch`'
    alias git.l="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"
    alias git.l2="git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset
    %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
    alias git.cm='git commit -m'
    alias git.cam='git commit -am'
    alias git.s='git status'
    alias git.d='git diff'
    alias git.='echo -e $__bash_green"git. shortcuts / commands
    "$__bash_cyan"git.a"$__bash_red" = "$__bash_yellow"git add
    "$__bash_cyan"git.a."$__bash_red" = "$__bash_yellow"git add .
    "$__bash_cyan"git.ps"$__bash_red" = "$__bash_yellow"git push `__git_remote_branch`
    "$__bash_cyan"git.pl"$__bash_red" = "$__bash_yellow"git pull `__git_remote_branch`
    "$__bash_cyan"git.pp"$__bash_red" = "$__bash_yellow"git pull `__git_remote_branch`; git push `__git_remote_branch`
    "$__bash_cyan"git.l"$__bash_red" = "$__bash_yellow"git log
    "$__bash_cyan"git.l2"$__bash_red" = "$__bash_yellow"git log summary
    "$__bash_cyan"git.cm"$__bash_red" = "$__bash_yellow"git commit -m
    "$__bash_cyan"git.cam"$__bash_red" = "$__bash_yellow"git commit -am
    "$__bash_cyan"git.s"$__bash_red" = "$__bash_yellow"git status
    "$__bash_cyan"git.d"$__bash_red" = "$__bash_yellow"git diff
    "$__bash_cyan"git.adc"$__bash_red" = "$__bash_yellow"git add [FILE], shows diff, prompts for message
    "$__bash_cyan"git.acm"$__bash_red" = "$__bash_yellow"git add [FILE], commits with [COMMENT]
    "$__bash_cyan"git.loop"$__bash_red" = "$__bash_yellow"Loops through all files that are not yet committed
    "$__bash_cyan"git.type"$__bash_red" = "$__bash_yellow"Returns a list of all files with that status (modified, both modified, new file, etc.)
    "$__bash_cyan"git."$__bash_red" = "$__bash_yellow"this message"$__bash_normal'

    alias git.key='eval $(ssh-agent) > /dev/null; ssh-add $HOME/.ssh/github_ssh/id_rsa'
    alias exit-tmux='tmux ls | awk '\''{print $1}'\'' | sed '\''s/://g'\'' | xargs -I{} tmux kill-session -t {}'
