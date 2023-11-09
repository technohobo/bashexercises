#!/bin/bash

INPUT=$1

INPUT=$(echo "$INPUT" | sed -e 's/\W//g; s/\(.*\)/\L\1/g')

LENGTH=${#INPUT}

for (( i=0; i<$LENGTH/2; i++ )); do
	if [[ ${INPUT:i:1} != ${INPUT:LENGTH-i-1:1} ]]; then
		echo "no"
		exit 1
	fi
done

echo "yes"
exit 0
