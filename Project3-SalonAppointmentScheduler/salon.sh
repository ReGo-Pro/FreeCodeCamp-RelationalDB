#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=salontest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=salon -t --no-align -c"
fi

function DISPLAY_SERVICES() {
  QUERY_RESULT=$($PSQL "SELECT * FROM services")
  FORMATTED_RES=${QUERY_RESULT//|/) }
  echo $FORMATTED_RES
}

function READ_CUSTOMER_PHONE() {
  # Some other checks can be in place like making sure the name does not include numbers in it
  while [[ -z $CUSTOMER_PHONE ]]
  do 
    echo "Please enter your phone number:"
    read CUSTOMER_PHONE
  done
}

function READ_CUSTOMER_NAME() {
  # Some other checks can be in place like making sure the name does not include numbers in it
  while [[ -z $CUSTOMER_NAME ]]
  do 
    echo "Please give us your name:"
    read CUSTOMER_NAME
  done
}

function READ_SERVICE_TIME() {
    while [[ -z $SERVICE_TIME ]]
    do 
      echo "Please book a time for your service:"
      read SERVICE_TIME
    done
}

# This works, but does not pass 1 of the tests (reading input test)
# function READ_INPUT() {
#   while [[ -z $USER_INPUT ]] 
#   do
#     read USER_INPUT
#   done
#   echo $USER_INPUT
# }

while [[ -z $SERVICE_EXISTS ]]
do 
  DISPLAY_SERVICES
  echo "Plese select a service number:"
  read SERVICE_ID_SELECTED
  SERVICE_EXISTS=$($PSQL "SELECT 1 FROM services WHERE service_id = $SERVICE_ID_SELECTED")
done

READ_CUSTOMER_PHONE
CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")
if [[ -z $CUSTOMER_NAME ]]
then 
  READ_CUSTOMER_NAME
  INSERT_RESULT=$($PSQL "INSERT INTO customers (name, phone) VALUES ('$CUSTOMER_NAME', '$CUSTOMER_PHONE')") 
fi 

READ_SERVICE_TIME
CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")
INSERT_RES=$($PSQL "INSERT INTO appointments (customer_id, service_id, time) VALUES ($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")

SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id='$SERVICE_ID_SELECTED'")
echo "I have put you down for a $SERVICE_NAME at $SERVICE_TIME, $CUSTOMER_NAME."