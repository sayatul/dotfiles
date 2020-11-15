function reshell() {
  source ~/.zshrc
}

function setenv() {
  if [ "$1" ]
    then
      env=$1
  else
    env=$(echo `basename $VIRTUAL_ENV`)
  fi

  export $(cat ~/Workspace/.env/common.sh | xargs)
  export $(cat ~/Workspace/.env/$env.sh | xargs)
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

function clearpyc() {
  find . -type f -name '*.pyc'
  find . -type f -name '*.pyc' -delete
}

function kubeapply () {
  if [ -z "$2" ]
  then
          context=$(kubectl config current-context)
  else
          context=$2
  fi
  echo "Deploying in context $context"
  cat $1 | sed s/\<RANDOM_ID\>/$(cat /dev/urandom  | LC_ALL=C tr -dc 'a-zA-Z0-9'| head -c 32)/ | kubectl apply --context="$context" -f -
}

function cl() {
  if [[ $1 = ch* ]];
  then
    ticket=$1
  else
    ticket="$(git branch --show-current).$1"
  fi
  
  echo "Creating changelog entry for $ticket"
  towncrier create $ticket
  
  echo $2 > changelog/$ticket
  cat changelog/$ticket
  
  echo "Adding to git 'changelog/$ticket'"
  git add changelog/$ticket
}

function gpo() {
  branch="$(git branch --show-current)" 
  git push origin $branch -f
  echo "in gpo"
}

function rebase() {  
  hub pull --rebase upstream $remote_branch
  if [ "$1" ]
    then
      gpo
  fi

}
