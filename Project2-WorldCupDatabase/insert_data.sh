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
    TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$1'")
  fi

  echo $TEAM_ID
}

cat games.csv | while IFS="," read YEAR ROUND WINNER_NAME OPPONENT_NAME WINNER_GOALS OPPONENT_GOALS
do 
  if [[ $YEAR != "year" ]] # skip first line
  then
    WINNER_ID=$(INSERT_TEAM "$WINNER_NAME")
    OPPONENT_ID=$(INSERT_TEAM "$OPPONENT_NAME")
    INSERT_RESULT=$($PSQL "INSERT INTO games (year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES ($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)")
  fi
done
