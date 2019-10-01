function setenv() {
  env=$(echo `basename $VIRTUAL_ENV`)
  export $(cat ~/.env/common.env | xargs)
  export $(cat ~/.env/$env.env | xargs)
}

pg-restore () {
    filename=$1
    db=${filename%.*}
    echo $db
    psql -c "create role LOGIN $db;"
    psql -c "drop database if exists $db;"
    psql -c "create database $db owner $db;"
    pg_restore --no-owner -v -U tryton -d $db $filename
}
