# git functions
    function __git_remote_branch () {
      echo `git remote` `git branch | sed -n '/\* /s///p'`
    }
    function git.adc () {
      echo -e $__bash_yellow"╔════════════════════════════════════════════════════════════════════════════╗"$__bash_normal
      echo -e $__bash_cyan"Diff on $1"$__bash_normal
      git diff $1
      echo -e $__bash_yellow"═════════════════════════════════════════════════════════════════════════════"$__bash_normal
      read -p "What do you want your comment to be? (default: \"Update $1\": " comment
      if [[ $ipaddress == "" ]]; then
        comment="Update $1"
      fi
      git add $1
      git commit -m comment
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
    "$__bash_cyan"git.d"$__bash_red" = "#__bash_yellow"git diff
    "$__bash_cyan"git.adc"$__bash_red" = "#__bash_yellow"git add [FILE], shows diff, prompts for message
    "$__bash_cyan"git.acm"$__bash_red" = "#__bash_yellow"git add [FILE], commits with [COMMENT]
    "$__bash_cyan"git."$__bash_red" = "$__bash_yellow"this message"$__bash_normal'
