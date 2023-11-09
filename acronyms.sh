#!/bin/bash

INPUT="$1"

INPUT=$(echo "$INPUT" | sed -e 's/-/ /g')

for w in $INPUT; do
	w=$(echo "$w" | sed -e 's/\W//')
	echo -n "${w:0:1}" | sed -e 's/\(\w\)/\U\1/'
done

