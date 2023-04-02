#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

function HANDLE_USER() {
  while [[ -z $USER_NAME ]] 
  do 
    read USER_NAME
  done

  IFS='|' read -r -a USER_INFO <<< $($PSQL "SELECT * FROM users WHERE name = '$USER_NAME'")  
  if [[ -z $USER_INFO ]]
  then
    echo "Welcome, $USER_NAME! It looks like this is your first time here."
    INSERT_RESULT=$($PSQL "INSERT INTO users (name, games_played, best_game) VALUES ('$USER_NAME', 0, 0)")
    IFS='|' read -r -a USER_INFO <<< $($PSQL "SELECT * FROM users WHERE name = '$USER_NAME'") 
  else 
    echo "Welcome back, ${USER_INFO[1]}! You have played ${USER_INFO[2]} games, and your best game took ${USER_INFO[3]} guesses."
  fi
}

# Pass secret_number as argument
function HANDLE_GUESSED_NUMBER() {
  SECRET_NUMBER=$1
  NUMBER_OF_GUESSES=0
  while [[ -z $GUESSED_NUMBER ]]
  do
    read GUESSED_NUMBER
    if [[ "$GUESSED_NUMBER" =~ ^[0-9]+$ ]]
    then 
      ### INNER if
      (( NUMBER_OF_GUESSES++ ))
      if [[ $GUESSED_NUMBER -lt $SECRET_NUMBER ]]
      then 
        echo "It's higher than that, guess again:"
        unset GUESSED_NUMBER
      elif [[ $GUESSED_NUMBER -gt $SECRET_NUMBER ]]
      then
        echo "It's lower than that, guess again:" 
        unset GUESSED_NUMBER
      else 
        echo "You guessed it in $NUMBER_OF_GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"
      fi
      ### END INNER if
    else 
      echo "That is not an integer, guess again:"
      unset GUESSED_NUMBER
    fi
  done
}

# Maybe refactor this
function SAVE_GAME_RESULT() {
  USER_ID=${USER_INFO[0]}
  CURRENT_BEST_GAME=${USER_INFO[3]}
  TOTAL_GAMES=${USER_INFO[2]}
  if [[ $CURRENT_BEST_GAME -eq 0 || $NUMBER_OF_GUESSES -lt $CURRENT_BEST_GAME ]]
  then 
    CURRENT_BEST_GAME=$NUMBER_OF_GUESSES
  fi
  (( TOTAL_GAMES++ ))
  # It is not an issue here, but concurrency considerations should be kept in mind
  UPDATE_RESULT=$($PSQL "UPDATE users set games_played = $TOTAL_GAMES, best_game = $CURRENT_BEST_GAME WHERE user_id = $USER_ID")
}

### main
SECRET_NUMBER=$(( RANDOM % 1000 ))
echo $SECRET_NUMBER
echo "Enter your username:"
HANDLE_USER
echo "Guess the secret number between 1 and 1000:"
HANDLE_GUESSED_NUMBER $SECRET_NUMBER
SAVE_GAME_RESULT