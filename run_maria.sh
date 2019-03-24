#!/bin/bash -eux

SCALE=$1
DBT3_HOME=$(dirname $(realpath "$0"))

export DSS_PATH=$DBT3_HOME/../data/$SCALE
rm -rf $DBT3_HOME/1/$SCALE $DBT3_HOME/2/$SCALE 

export DSS_CONFIG=$DBT3_HOME/src/dbgen
export PATH=$DBT3_HOME/scripts:$PATH
export DBGEN=$DSS_CONFIG/dbgen
export QGEN=$DSS_CONFIG/qgen
export DBNAME=dbt3

export PATH=/opt/mariadb-10.3.13/bin:$PATH
export PATH=/opt/mariadb-10.3.13/scripts:$PATH
export MYDATA=$DBT3_HOME/mydata

export DSS_QUERY=$DBT3_HOME/queries/mysql
export PATH=$DBT3_HOME/scripts/mysql:$PATH

bash -x $DBT3_HOME/scripts/dbt3-run-workload -1 -f $SCALE -o $DBT3_HOME/1/$SCALE -a mysql
bash -x $DBT3_HOME/scripts/dbt3-run-workload -2 -f $SCALE -o $DBT3_HOME/2/$SCALE -a mysql
