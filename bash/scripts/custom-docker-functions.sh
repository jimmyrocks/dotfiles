# Docker functions
function dc.bash() {
  docker-compose exec $1 bash
}

function dc.bash() {
  sudo docker-compose exec $1 bash
}

function sdc.load() {
  filename=${$1:='docker-compose.yml'}
  sudo docker-compose build -f $filename
  sudo docker-compose up -f $filename
}

function sdc.reload() {
  filename=${$1:='docker-compose.yml'}
  sudo docker-compose down -f $filename
  sudo dc.load $filename
}

function dc.load() {
  filename=${$1:='docker-compose.yml'}
  docker-compose build -f $filename
  docker-compose up -f $filename
}

function dc.reload() {
  filename=${$1:='docker-compose.yml'}
  docker-compose down -f $filename
  dc.load $filename
}

function sdc.ps() {
  sudo docker-compose ps
}

# Docker aliases
dc='docker-compose'
sdc='sudo docker-compose'
