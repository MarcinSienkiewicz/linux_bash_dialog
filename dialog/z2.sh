#!/bin/bash

exec 2>errors.txt

arguments=""
function finished() {
	dialog --cr-wrap --title "End" --msgbox "Script ended.
	\nNO modifications." 7 45 
	clear
	exit 1
}

function getInput() {
	arguments=$(dialog --title "$2" --inputbox\
	       "$1" 8 50 --stdout)
	if [ $? != 0 ]; then
		finished
	fi
}

function create() {
	call="[creating $1] specify name(s):"
	title="Create $1"
	getInput "$call" "$title"

	operation=$1
	IFS=" " read -r -a this_list <<< "$arguments"

	for element in "${this_list[@]}"; do
		if [ $operation = "file" ]; then
		`touch $element`
	elif [ $operation = "directory" ]; then
		`mkdir -p $element`
		fi

	done
}

function delete() {
	call="[deleting] specify name(s): "
	title="Recursive delete"
	getInput "$call" "$title" 
	IFS=" " read -r -a for_deletion <<< "$arguments"

	for element in "${for_deletion[@]}"; do
		`rm -r $element `
	done
	echo ""
}

function cpmv() {
	call="[$1] Specify two arguments separated by space [SOURCE DESTINATION]:"
	if [ $1 = "cp" ]; then
		title="Copying"
	elif [ $1 = "mv" ]; then
		title="Moving"
	fi

	getInput "$call" "$title"
	IFS=" " read -r -a values <<< "$arguments"
	`$1 ${values[0]} ${values[1]}`
}

option=$(dialog --backtitle "Files and folders operations." --title "Operations menu" --radiolist "Action selection:" 13 30 6\
	1 "Create file" on\
	2 "Create directory" off\
	3 "Delete" off\
	4 "Copy" off\
	5 "Move" off\
	6 "Exit" off --stdout)
escape=$?

if [[ $escape -eq 1 ]] || [[ $escape -eq 255 ]] || [[ $option -eq 6 ]]; then
	finished
else
	case $option in
		1) create "file";;
		2) create "directory";;
		3) delete;;
		4) cpmv "cp";;
		5) cpmv "mv";;
	esac
fi

# error check
if [ -f errors.txt ] && [ -s errors.txt ]; then	
	read -r error < errors.txt
	dialog --title "Error" --msgbox "$error" 7 50
else
	dialog --title "Success" --msgbox "Operation successful" 5 50
fi
rm errors.txt
clear
