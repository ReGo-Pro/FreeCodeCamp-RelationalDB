#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=salontest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=salon -t --no-align -c"
fi

QUERY_RESULT=$($PSQL "SELECT * FROM services")
FORMATTED_RES=${QUERY_RESULT//|/) }
echo $FORMATTED_RES
