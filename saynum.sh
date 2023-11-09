#!/bin/bash

X=$1

SINGLESARR=( "one" "two" "three" "four" "five" "six" "seven" "eight" "nine" )
TENSARR=( "twenty" "thirty" "forty" "fifty" "sixty" "seventy" "eighty" "ninety" )
TEENSARR=( "ten" "eleven" "twelve" "thirteen" "fourteen" "fifteen" "sixteen" "seventeen" "eighteen" "nineteen" )

if [[ $X -lt 0 || $X -gt 999999999999 ]]; then
	echo "Invalid range!"
	exit 1
elif [[ $X -eq 0 ]]; then
	echo "zero"
	exit 0
fi

BILLIONS=$(( $X / 10**9 ))
X=$(( $X - $BILLIONS * 10**9 ))

MILLIONS=$(( $X / 10**6 ))
X=$(( $X - $MILLIONS * 10**6 ))

THOUSANDS=$(( $X / 10**3 )) 
X=$(( $X - $THOUSANDS * 10**3 ))

REST=$X

numbersToWords(){
	NUM=$1

	if [[ $NUM -le 0 ]]; then
		return 2
	fi

	HUNDREDS=$(( $NUM / 100 ))
	NUM=$(( $NUM - $HUNDREDS * 100 ))

	if [[ $HUNDREDS -gt 0 ]]; then
		echo -n "${SINGLESARR[$HUNDREDS-1]} hundred "
	fi


	TENS=$(( $NUM / 10 ))

	if [[ $TENS -gt 1 ]]; then 
		echo -n "${TENSARR[$TENS-2]}"
	elif [[ $NUM -ge 10 && $NUM -lt 20 ]]; then
		echo -n "${TEENSARR[$NUM-10]} "
		return 0
	else
		if [[ $NUM -gt 0 ]]; then
			echo -n "${SINGLESARR[$NUM-1]} "
		fi
		return 0
	fi

	NUM=$(( $NUM - $TENS * 10 ))

	if [[ $TENS -gt 0 && $NUM -gt 0 ]]; then
		echo -n "-"
	fi

	if [[ $NUM -gt 0 ]]; then
		echo -n "${SINGLESARR[$NUM-1]} "
	fi
	
	return 0

}

numbersToWords $BILLIONS && echo -n "billion "
numbersToWords $MILLIONS && echo -n "million "
numbersToWords $THOUSANDS && echo -n "thousand "
numbersToWords $REST
