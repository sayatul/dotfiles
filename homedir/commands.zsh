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



function gpo() {
  branch="$(git branch --show-current)" 
  git push origin $branch -f
  echo "in gpo"
}


function task() {
  branch="$(git branch --show-current)" 
  club story -q $branch
}


function yubi() {
  killall -9 ssh-agent gpg-agent
  if [ "$1" ]
    then
      echo "Activating 5ci"
      cp -r /Users/say/.gnupg/ci-keys.d/* /Users/say/.gnupg/private-keys-v1.d
  else
    echo "Activating 5nfc"
    cp -r /Users/say/.gnupg/nfc-key.d/* /Users/say/.gnupg/private-keys-v1.d
  fi
  /usr/local/MacGPG2/bin/gpg2 --card-status &> /dev/null
  eval $(/usr/local/MacGPG2/bin/gpgconf --launch gpg-agent)  
}


function cl() {

  story=$(git branch --show-current | rev | cut -d'-' -f 1 | rev)

  echo "Creating changelog entry for $story.$1"
  echo $2 > changelog/$story.$1
  cat changelog/$story.$1

  echo "Adding to git 'changelog/$story.$1'"
  git add changelog/$story.$1

  echo "Committing changes"
git commit -am "
$2


[$story]
"
}

function gke_proxy() {
	SOCKET="$HOME/.ssh/gke-maint-proxy"
	function proxy_status() {
		if [[ ! -S "$SOCKET" ]]; then
			echo "not running"
			return;
		fi
		ssh -S $SOCKET -O check maint
		if [[ "$?" -ne 0 ]]; then
			echo "not running"
			return;
		fi
		echo "running";
	}
	case $1 in
	  start)
	    if [[ "$(proxy_status)" == "running" ]]; then
	            echo "Already running"
	            return;
	    fi
	    echo -ne "Starting portfwd...%\033[0K\r"
	    # apps 34.74.170.140
	    ssh -qfNTM \
		    -L 9140:34.74.170.140:443 \
		    -S $SOCKET maint
	    echo -ne "\rPortfwd started"
	    ;;
	  stop)
	    if [[ "$(proxy_status)" != "running" ]]; then
	            echo "Not running"
	            return;
	    fi
	    echo -ne "Stopping proxy...%\033[0K\r"
	    ssh -S $SOCKET -O exit maint
	    echo -ne "\rProxy stopped"
	    ;;
	  *)
	    echo "Status: $(proxy_status)"
	    echo "Usage: \t gke-proxy <start|stop|status>"
	    ;;
	esac
}
