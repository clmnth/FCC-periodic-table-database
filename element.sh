#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

if [[ -z $1 ]]; then
  echo "Please provide an element as an argument."
else
  INPUT=$1

  # if input is a number
  if [[ $INPUT =~ ^[0-9]+$ ]]; then
    echo "It's a number."
    INPUT_NUMBER_EXIST=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$INPUT")
    if [[ -z $INPUT_NUMBER_EXIST ]]; then
      echo "I could not find that element in the database."
    else
      echo "I have this element in the database!"
    fi

  # if input is a NOT a number
  else 
    echo "It's not a number."
    INPUT_TEXT_EXIST=$($PSQL "SELECT symbol, name FROM elements WHERE symbol='$INPUT' OR name='$INPUT'")
    if [[ -z $INPUT_TEXT_EXIST ]]; then
      echo "I could not find that element in the database."
    else
       echo "I have this element in the database!"
    fi


  fi
fi
