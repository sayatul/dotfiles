function reshell() {
  source ~/.zshrc
}

function setenv() {
  env=$(echo `basename $VIRTUAL_ENV`)
  export $(cat ~/.env/common.sh | xargs)
  export $(cat ~/.env/$env.sh | xargs)
}

function pg-restore () {
    filename=$1
    db=${filename%.*}
    echo $db
    psql -c "create role LOGIN $db;"
    psql -c "drop database if exists $db;"
    psql -c "create database $db owner $db;"
    pg_restore --no-owner -v -U tryton -d $db $filename
}

function pullpr() {
  echo "Pulling ${2:-upstream} pr $1"
  git fetch ${2:-upstream} pull/$1/head:"GH-$1"
  git checkout "GH-$1"
}

function gpo() {
  git push origin $1 -f
}

function clearpyc() {
  find . -type f -name '*.pyc'
  find . -type f -name '*.pyc' -delete
}
