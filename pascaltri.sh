#!/bin/bash

N=$1
SPACES=$N-1
PREVROW=( 1 1 )
NEWROW=()

if [[ $N -lt 1 ]]; then
	echo "Invalid input!"
	exit 1
fi

for (( j=0;j<$SPACES; j++ )); do
	echo -n " "
done
echo 1

if [[ $N -eq 1 ]]; then
	exit 0
fi

for (( i=0; i<$N-1; i++ )); do
	for (( j=0;j<$SPACES-1; j++ )); do
		echo -n " "
	done

	SPACES=$(( SPACES - 1 ))
	echo ${PREVROW[@]}

	LENGTH=${#PREVROW[@]}
	NEWROW=( 1 )
	
	for (( j=1; j<$LENGTH; j++ )); do
		RES=$(( ${PREVROW[$j]} + ${PREVROW[$j-1]} ))
		NEWROW+=( $RES )
	done
	
	NEWROW+=( 1 )
	PREVROW=( ${NEWROW[@]} )

done
