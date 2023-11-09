#!/bin/bash

INPUT=$1

# Check input string format
if [[ ! $INPUT =~ ^.-.{3}-.{5}-.$ ]]; then
	echo "Improper ISBN format!"
	exit 1
fi

# Change dashes into spaces and put every section into a list
INPUT=$( echo "$INPUT" | sed -e 's/-//g; s/\(.\)/\1 /g' )
SEPLIST=( $INPUT )

#echo "${SEPLIST[@]}"
# Check if every section except the last one is a digit
for SPLIT in ${SEPLIST[@]:0:9}; do
	if [[ ! $SPLIT =~ [0-9] ]]; then
		echo "Invalid characters!"
		exit 2
	fi
done

# Check if checksum is a digit or "x" character
if ! [[ ${SEPLIST[9]} =~ [0-9] || ${SEPLIST[9]} == "X" ]]; then
	echo "Invalid characters!"
	exit 2
fi


# Convert "x" character to number 10
if [[ ${SEPLIST[9]} == "X" ]]; then
	SEPLIST[9]=10
fi


CHECKSUM=0

for (( i=0; i<10; i++ )); do
	CHECKSUM=$(( $CHECKSUM + ${SEPLIST[i]} * (10-$i) ))
done


if [[ `expr $CHECKSUM % 11` -eq 0 ]]; then
	echo "Valid ISBN number!"
	exit 0
else
	echo "Invalid ISBN number!"
	exit 3
fi

