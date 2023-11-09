#!/bin/bash

INPUT=$1

if [[ $INPUT -le 0 ]]; then
	echo "Input must be bigger than 0!"
	exit 1
fi

if [[ $INPUT -eq 1 ]]; then
	echo 2
	exit 0
fi

PRIMENUMBERS=( 2 )
PRIMEFLAG=1

for (( BIGGEST=3; ${#PRIMENUMBERS[@]} < $INPUT; BIGGEST+=2 )); do
	for n in ${PRIMENUMBERS[@]}; do
		if [[ `expr $BIGGEST % $n` -eq 0 ]]; then
			PRIMEFLAG=0
			break
		fi
	done
	if [[ $PRIMEFLAG -eq 1 ]]; then
		PRIMENUMBERS+=( $BIGGEST )
	fi
	PRIMEFLAG=1
done

echo ${PRIMENUMBERS[@]}
exit 0
