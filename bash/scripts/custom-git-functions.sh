# git functions
    function __git_remote_branch () {
      echo 'origin' `git branch | sed -n '/\* /s///p'`
    }

    function __git_commit_file () {
      git add $1
      _basefile=$(basename $1)
      read -r -e -p "What do you want your comment to be? (default: \"Update $_basefile\"): " comment
      if [ $comment == "" ]; then
        comment="Update $_basefile"
      fi
      git commit -m "$comment"
    }

    function git.loop () {
      git_dir=`git rev-parse --show-toplevel`
      git_files=`git status --porcelain | grep '^[ M]M ' | sed -e 's/^[ M]M\s//g'`
        for git_file in $git_files; do
          echo -e $__bash_yellow"╔════════════════════════════════════════════════════════════════════════════╗"$__bash_normal
            read -r -e -p "Add the file? (y/N/d): $git_dir/$git_file: " char
            if [ $char == "d" -o $char == "D" ]; then
              git.adc $git_dir'/'$git_file
            fi
            if [ $char == "y" -o $char == "Y" ]; then
              __git_commit_file $git_dir'/'$git_file
            fi
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


# git aliases
    alias git.a='git add'
    alias git.a.='git add .'
    alias git.ps='git push `__git_remote_branch`'
    alias git.pl='git pull `__git_remote_branch`'
    alias git.pp='git pull `__git_remote_branch`; git push `__git_remote_branch`'
    alias git.l="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset"
    alias git.l2="git log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset
    %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
    alias git.cm='git commit -m'
    alias git.cam='git commit -am'
    alias git.s='git status'
    alias git.d='git diff'
    alias exit-tmux='tmux ls | awk '\''{print $1}'\'' | sed '\''s/://g'\'' | xargs -I{} tmux kill-session -t {}'
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
    "$__bash_cyan"git."$__bash_red" = "$__bash_yellow"this message"$__bash_normal'
