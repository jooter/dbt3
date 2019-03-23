#!/bin/bash -eux

SCALE=$1

DBT3_HOME=$(dirname $(realpath $0))

export DSS_PATH=$DBT3_HOME/../data/$SCALE

export DSS_CONFIG=$DBT3_HOME/src/dbgen
export PATH=$DBT3_HOME/scripts:$PATH
export DBGEN=$DSS_CONFIG/dbgen
export QGEN=$DSS_CONFIG/qgen
export PGDATABASE=dbt3

export PATH=/opt/pgsql-10/bin:$PATH
export PGDATA=$DBT3_HOME/mydata

export DSS_QUERY=$DBT3_HOME/queries/pgsql
export PATH=$DBT3_HOME/scripts/pgsql:$PATH

rm -rf $DBT3_HOME/1/$SCALE $DBT3_HOME/2/$SCALE 

$DBT3_HOME/scripts/dbt3-run-workload -1 -f $SCALE -o $DBT3_HOME/1/$SCALE -a pgsql -e
$DBT3_HOME/scripts/dbt3-run-workload -2 -f $SCALE -o $DBT3_HOME/2/$SCALE -a pgsql -e
