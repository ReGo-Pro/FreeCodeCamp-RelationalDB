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

# Pass element_id as argument
function GET_ELEMENT_PROPERTIES() {
  # Input validations go here
  echo $($PSQL "SELECT * FROM properties WHERE atomic_number=$1")
}

# Pass type_id as argument
function GET_ELEMENT_TYPE() {
  # Input validations go here
  echo $($PSQL "SELECT type FROM types WHERE type_id=$1")
}

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else 
  ELEMENT=$(GET_ELEMENT $1)
  if [[ -z $ELEMENT ]]
  then 
    echo "I could not find that element in the database."
  else
    IFS='|' read -r -a ELEMENT_INFO <<< $ELEMENT
    IFS='|' read -r -a ELEMENT_PROPERTIES <<< $(GET_ELEMENT_PROPERTIES ${ELEMENT_INFO[0]})
    ELMENT_TYPE=$(GET_ELEMENT_TYPE ${ELEMENT_PROPERTIES[4]})
    echo "The element with atomic number ${ELEMENT_INFO[0]} is ${ELEMENT_INFO[2]} (${ELEMENT_INFO[1]}). It's a $ELMENT_TYPE, with a mass of ${ELEMENT_PROPERTIES[1]} amu. ${ELEMENT_INFO[2]} has a melting point of ${ELEMENT_PROPERTIES[2]} celsius and a boiling point of ${ELEMENT_PROPERTIES[3]} celsius."
  fi
fi