#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
function INSERT_TEAM() {
  TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$1'")
  if [[ -z $TEAM_ID ]]
  then
    INSERT_RESULT=$($PSQL "INSERT INTO teams (name) VALUES ('$1')")
    if [[ $INSERT_RESULT == "INSERT 0 1" ]]
    then
      echo "Succeessfully inserted team: $1"
    else 
      echo "Some error occured please make sure database is connected and try again"
    fi
  fi
}

cat games.csv | while IFS="," read YEAR ROUND WINNER_NAME OPPONENT_NAME WINNER_GOALS OPPONENT_GOALS
do 
  if [[ $YEAR != "year" ]] # skip first line
  then 
    INSERT_TEAM "$WINNER_NAME"
    INSERT_TEAM "$OPPONENT_NAME"
  fi
done
