#!/bin/bash
INPUT=$1

INPUT=$(echo "$INPUT" | sed -e 's/\W//g; s/\(.*\)/\L\1/g')

for letter in {a..z}; do
	if [[ ! $INPUT =~ $letter ]]; then
		echo no
		exit 1
	fi
done

echo yes
exit 0
