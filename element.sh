#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --tuples-only  -c"

if [[ -z $1 ]]
then
echo "Please provide an element as an argument."
exit
fi

if [[ $1 =~ ^[1-9]+$ ]]
then
element=$($PSQL "SELECT * FROM elements FULL JOIN properties USING(atomic_number) join types USING(type_id) WHERE atomic_number=$1")

else
element=$($PSQL "SELECT * FROM elements FULL JOIN properties USING(atomic_number) join types USING(type_id) WHERE symbol='$1' OR name='$1'")
fi

if [[ -z $element ]]
then
echo "I could not find that element in the database."
exit
fi

echo "$element" | while read TYPE_ID BAR ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR ATOMIC_MASS BAR MELTING_POINT BAR BOILING_POINT BAR TYPE
do
echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."

done