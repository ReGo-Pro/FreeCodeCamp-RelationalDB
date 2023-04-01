#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

function GET_ELEMENT() {
  if [[ "$1" =~ ^[0-9]+$ ]]
  then 
    ELEMENT=$($PSQL "SELECT * FROM elements WHERE atomic_number=$1")
  else 
    ELEMENT=$($PSQL "SELECT * FROM elements WHERE name='$1' OR symbol='$1'")
  fi
  echo $ELEMENT
}

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else 
  IFS='|' read -r -a ELEMENT_INFO <<< $(GET_ELEMENT $1)
fi