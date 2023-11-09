#!/bin/bash

INPUT="$1"
LENGTH="${#INPUT}"
OUTPUT=""

for (( i=$LENGTH; i>=0; i-- )); do
	OUTPUT="$OUTPUT${INPUT:i:1}"
done

echo "$OUTPUT"
