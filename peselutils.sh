#!/bin/bash

INPUT=$1

if ! [[ ${#INPUT} -eq 11 && "$INPUT" =~ ^[0-9]+$ ]]; then
	echo "Invalid input!"
	exit 1
fi

evalChecksum(){
	IN=$1

	W=( 1 3 7 9 )
	WI=0
	SUM=0
	for (( i=0; i<10; i++ )); do
		SUM=$(( $SUM + ${W[$WI]} * ${IN:i:1} ))
		if [[ $WI -eq 3 ]]; then
			WI=0
		else
			WI=$(( $WI + 1 ))
		fi
	done

	SUM=$(( $SUM + ${IN:10:1} ))

	if [[ "${SUM:${#SUM}-1:1}" -eq "0" ]]; then
		return 0
	else
		return 1
	fi

}

showData(){
	IN=$1

	YEAR=${IN:0:2}
	MONTH=${IN:2:2}
	DAY=${IN:4:2}
	SERIES=${IN:6:4}
	CHECKNUM=${IN:10:1}
	SEX=""

	if [[ `expr ${IN:9:1} % 2` -eq 0 ]]; then
		SEX="F"
	else
		SEX="M"
	fi

	CENTURY=$(( $MONTH / 20 ))
	MONTH=$(( $MONTH % 20))

	if [[ $CENTURY -eq 4 ]]; then
		CENTURY=-1
	fi

	if [[ $MONTH -gt 12 ]]; then
		echo "Invalid month!"
		return 1
	fi

	YEAR=$(( 1900+100*$CENTURY ))

	echo "Date of birth: $DAY.$MONTH.$YEAR"
	echo "Sex: $SEX"
	echo "Series: $SERIES"
	echo "Checknum: $CHECKNUM"

	return 0

}



evalChecksum "$INPUT"
SUMCHECK=$?

if [[ $SUMCHECK -eq 0 ]]; then
	showData "$INPUT" && exit 0
	echo "Something happened..."
	exit 2
else
	echo "Invalid PESEL!"
	exit 2
fi

