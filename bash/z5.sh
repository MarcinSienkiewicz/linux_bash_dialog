#!/usr/bin/bash

function replace() {
	original=$1
	changed=$2

	read -p "Enter text: " words
	printf "\nReplace:\n(f)irst\n(a)ll\noccurrences: "
	read choice
	
	if [[ $choice = "f" ]]; then
		result="${words/$original/$changed}"
	elif [[ $choice = "a" ]]; then
		result="${words//$original/$changed}"
	else
		printf "\nUnknown option!"
		exit 1
	fi
	printf "\nAfter modification:\n"
	echo "$result"
}

read -p "Old (to be replaced): " old 
read -p "New (replace with): " new
replace $old $new
