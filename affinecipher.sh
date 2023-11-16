#!/bin/bash

ALPHABET=( {a..z} )
NUMIN=()
M=${#ALPHABET[@]}
DIVA=()

showParams(){
	echo "$FLAG $A $B $INPUT"
}

showHelp(){
	echo "affinecipher.sh [e|d] -a NUM -b NUM STRING"
	echo -e "\te \tEncrypt"
	echo -e "\td \tDecrypt"
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
# for whatever reason if the first parameter is with a "-" it gets read as n empty string by the script...
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

INPUT="$6"
OUTPUT=""

for (( i=2; i<$M; i++ )); do
	if [[ `expr $A % $i` -eq 0 && `expr $M % $i` -eq 0 ]]; then
		echo "A and M are not coprime!"
		exit 3

	fi
done

# Convert INPUT to a list of numbers corresponding to each letter position in the alphabet
for (( i=0; i<${#INPUT}; i++ )); do
	CHAR="${INPUT:i:1}"

	for (( j=0; j<$M; j++)); do
		if [[ "${ALPHABET[j]}" == "$CHAR" ]]; then
			NUMIN+=( $(( $j )) )
			break
		fi
	done
done

encrypt(){
	for (( i=0; i<${#NUMIN[@]}; i++ )); do
		CHAR=${NUMIN[i]}

		CHAR=$(( ( $A * $CHAR + $B ) % $M ))
		OUTPUT+="${ALPHABET[$CHAR]}"
	done
}	

countMMI(){
	for (( x=1; x<$M; x++ )); do
		MMI=$(( ( $x * $A ) % $M ))

		if [[ $MMI -eq 1 ]]; then
			return $x
		fi
	done
	return -1
}

decrypt(){
	countMMI
	MMI=$?

	for (( i=0; i<${#NUMIN[@]}; i++ )); do
		CHAR=${NUMIN[i]}

		CHAR=$(( $MMI * ( $CHAR - $B ) % $M ))
		OUTPUT+="${ALPHABET[$CHAR]}"
	done

}

if [[ "$FLAG" == "e" ]]; then
	encrypt
elif [[ "$FLAG" == "d" ]]; then
	decrypt
fi

echo "$OUTPUT"
exit 0
