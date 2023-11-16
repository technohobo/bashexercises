#!/bin/bash

ALPHABET=( {a..z} )
NUMIN=()
M=26

showParams(){
	echo "$FLAG $A $B $STR"
}

showHelp(){
	echo "affinecipher.sh [-e|-d] -a NUM -b NUM STRING"
	echo -e "\t-e \tEncrypt"
	echo -e "\t-d \tDecrypt"
	echo -e "\t-a \tThe 'a' parameter"
	echo -e "\t-b \tThe 'b' parameter"
	echo -e "\tSTRING \tString that is to be encrypted/decrypted"
}

# Check parameter count
if [[ $# -ne 6 ]]; then
	showHelp
	echo $A
	exit 1
fi

# Parameter parsing
if [[ "$1" != "e" && "$1" != "d" ]]; then
	echo "Invalid parameters..."
	showHelp
	exit 2
else
	FLAG="$1"
fi

if [[ "$2" == "-a" ]]; then
	A="$3"
elif [[ "$2" == "-b" ]]; then
	B="$3"
else
	echo "Invalid parameters..."
	showHelp
	exit 2
fi

if [[ "$4" == "-a" ]]; then
	A="$5"
elif [[ "$4" == "-b" ]]; then
	B="$5"
else
	echo "Invalid parameters..."
	showHelp
	exit 2
fi

if [[ "$A" == "" || "$B" == "" ]]; then
	echo "Invalid parameters..."
	showHelp
	exit 2
fi

STR="$6"

# Testing parsing...
# showParams


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
