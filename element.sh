#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"

if [[ -z $1 ]]; then
  echo "Please provide an element as an argument."
else
  INPUT=$1

  # if input is a number
  if [[ $INPUT =~ ^[0-9]+$ ]]; then
    ELEMENT_DATA=$($PSQL "SELECT elements.atomic_number, elements.symbol, elements.name, types.type, properties.atomic_mass, properties.melting_point_celsius, properties.boiling_point_celsius FROM elements INNER JOIN properties USING (atomic_number) INNER JOIN types USING (type_id) WHERE atomic_number=$INPUT")
    if [[ -z $ELEMENT_DATA ]]; then
      echo "I could not find that element in the database."
    else
      echo "$ELEMENT_DATA" | while read NUMBER BAR SYMBOL BAR NAME BAR TYPE BAR MASS BAR MELTING BAR BOILING
      do
        echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
      done
    fi

  # if input is a NOT a number
  else 
    ELEMENT_DATA=$($PSQL "SELECT elements.atomic_number, elements.symbol, elements.name, types.type, properties.atomic_mass, properties.melting_point_celsius, properties.boiling_point_celsius FROM elements INNER JOIN properties USING (atomic_number) INNER JOIN types USING (type_id) WHERE symbol='$INPUT' OR name='$INPUT'")
    if [[ -z $ELEMENT_DATA ]]; then
      echo "I could not find that element in the database."
    else
       echo "$ELEMENT_DATA" | while read NUMBER BAR SYMBOL BAR NAME BAR TYPE BAR MASS BAR MELTING BAR BOILING
       do
         echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
       done
    fi
  fi
fi
