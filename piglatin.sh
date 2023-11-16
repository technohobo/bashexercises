#!/bin/bash

WORDS=( $@ )
VOWELS=( "a" "i" "u" "e" "o" "y" )

for WORD in ${WORDS[@]}; do
	WORDLENGTH=${#WORD}
	CONSONANTS=""
	VOWELNUM=-1

	for (( i=0; i<${#WORD}; i++ )); do
		for V in ${VOWELS[@]}; do
			if [[ "${WORD:$i:1}" == "$V" || "${WORD:$i:2}" == "xr" || "${WORD:$i:2}" == "xt" ]]; then 
				VOWELNUM=$i
				break
			fi
		done

		if [[ $VOWELNUM -ge 0 ]]; then
			break	
		fi

		CONSONANTS+="${WORD:$i:1}"

		if [[ "${WORD:$i+1:2}" == "qu" ]]; then
			VOWELNUM=$(( $i + 3 ))
			CONSONANTS="${CONSONANTS}qu"
			break 
		fi

	done

	echo -n "${WORD:$VOWELNUM:$WORDLENGTH-$VOWELNUM}${CONSONANTS}ay "

done
