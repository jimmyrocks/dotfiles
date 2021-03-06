# Docker functions

function dc.load() {
  filename=$1
  filename=${filename:='docker-compose.yml'}
  sudo docker-compose -f $filename build
  sudo docker-compose -f $filename up
}

function dc.reload() {
  filename=$1
  filename=${filename:='docker-compose.yml'}
  dc.down $filename
  dc.load $filename
}

function dc.down() {
  filename=$1
  filename=${filename:='docker-compose.yml'}
  sudo docker-compose -f $filename down
}

function dc.bash() {
  container=$1
  filename=$2
  filename=${filename:='docker-compose.yml'}
  sudo docker-compose -f $filename exec $container bash
}

function dc.ps() {
  sudo docker-compose ps
}

# Docker aliases
alias dc='sudo docker-compose'
