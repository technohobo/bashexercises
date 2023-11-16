#!/bin/bash

INPUT=$3
ALPHABET=( {a..z} )
NUMIN=()
A=$1
B=$2
M=26


showHelp(){
	echo "affinecipher.sh [-e|-d] -a NUM -b NUM STRING"
	echo -e "\t-e \tEncrypt"
	echo -e "\t-d \tDecrypt"
	echo -e "\t-a \tThe 'a' parameter"
	echo -e "\t-b \tThe 'b' parameter"
	echo -e "\tSTRING \tString that is to be encrypted/decrypted"
}

if [[ $# -ne 6 ]]; then
	showHelp
	exit 1
fi

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
