#!/bin/bash

INPUT=$3
ALPHABET=( {a..z} )
NUMIN=()
A=$1
B=$2
M=26


for (( i=0; i<${#INPUT}; i++ )); do
	CHAR=${INPUT:i:1}

	for (( j=0; j<${#ALPHABET[@]}; j++)); do
		if [[ "${ALPHABET[j]}" == "$C" ]]; then
			NUMIN+=( $(( $j+1 )) )
			break
		fi
	done
done

for (( i=0; i<${NUMIN[@]}; i++ )); do
	C=${NUMIN[i]}
	I=0

	for (( j=0; j<26 j++ )); do
		if [[ "$C" == ${ALPHABET[j]} ]]; then
			I=$j
			break
		fi
	done
	NUMIN[i]=$(( ( $A * $I + $B ) % $M ))

done

echo -n ${NUMIN[*]}
