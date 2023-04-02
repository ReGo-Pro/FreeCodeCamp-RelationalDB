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
  USER_EXISTS=$($PSQL "SELECT 1 FROM users WHERE name='$1'")
  if [[ $USER_EXISTS == 1 ]]
  then 
    echo echo "Welcome back, $1! You have played <games_played> games, and your best game took <best_game> guesses."
  else 
    echo "Welcome, $1! It looks like this is your first time here."
  fi
}

GENERATED_NUMBER=$(( RANDOM % 1000 ))
echo "Enter your username:"
READ_USER_NAME
HANDLE_USER $USER_NAME