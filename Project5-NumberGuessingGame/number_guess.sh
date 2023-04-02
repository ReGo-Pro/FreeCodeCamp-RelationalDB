#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

function READ_USER_NAME() {
  while [[ -z $USER_NAME ]] 
  do 
    read USER_NAME
  done
}

# Pass user-name as argument
function HANDLE_USER() {
  IFS='|' read -r -a USER_INFO <<< $($PSQL "SELECT 1 FROM users WHERE name='$1'")  
  if [[ -z $USER_INFO ]]
  then
    echo "Welcome, $1! It looks like this is your first time here."
    INSERT_RESULT=$($PSQL "INSERT INTO users (name, games_played, best_game) VALUES ('$1', 0, 0)")
  else 
    echo "Welcome back, $1! You have played ${USER_INFO[2]} games, and your best game took ${USER_INFO[3]} guesses."
  fi
}

# Pass generated_number as argument
function HANDLE_GUESSED_NUMBER() {
  GENERATED_NUMBER=$1
  while [[ -z $GUESSED_NUMBER ]]
  do
    read GUESSED_NUMBER
    if [[ "$GUESSED_NUMBER" =~ ^[0-9]+$ ]]
    then 
      ### INNER if
      if [[ $GUESSED_NUMBER -lt $GENERATED_NUMBER ]]
      then 
        echo "It's higher than that, guess again:"
        unset GUESSED_NUMBER
      elif [[ $GUESSED_NUMBER -gt $GENERATED_NUMBER ]]
      then
        echo "It's lower than that, guess again:" 
        unset GUESSED_NUMBER
      else 
        echo "You guessed it in <number_of_guesses> tries. The secret number was <secret_number>. Nice job!"
      fi
      ### END INNER if
    else 
      echo "That is not an integer, guess again:"
      unset GUESSED_NUMBER
    fi
  done
}

# $1: guessed number - $2 generated number
function GAME_LOGIC() {
  echo "$1 -- $2" 
}

### main
GENERATED_NUMBER=$(( RANDOM % 1000 ))
echo $GENERATED_NUMBER
echo "Enter your username:"
READ_USER_NAME
HANDLE_USER $USER_NAME
echo "Guess the secret number between 1 and 1000:"
HANDLE_GUESSED_NUMBER $GENERATED_NUMBER