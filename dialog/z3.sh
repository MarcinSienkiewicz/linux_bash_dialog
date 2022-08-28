#!/bin/bash

function finish() {
	dialog --title "Finish" --msgbox "$1" 5 40
}


source=$(dialog --title "Select SOURCE folder" --fselect "" 25 60 --stdout)
source="$source/"

if [ $source = "/" ]; then
	source=$(pwd)
	source="$source/"
fi


if [ $? != 0 ]; then
	finish "Script interrupted"
	clear
	exit 1
fi

if [ -z $source ] || [ ! -d $source ]; then
	finish "Select existing directory."
	clear
	exit 1
fi

filesArr=(`ls -p $source | grep -v /`)


newArr=()
for((i=0; i<${#filesArr[@]}; i++)); do
	newArr[$i]="$i ${filesArr[$i]} off"
done


forCopy=$(dialog --title "Copying files" --checklist "Select files to be copied:" 25 60 ${#newArr[@]}\
	${newArr[@]} --stdout)

if [ $? != 0 ]; then
	finish "Script interrupted"
	clear
	exit 1
fi

if [ -z $forCopy ]; then
	finish "Choose at least one file."
	clear
	exit 1
fi

correctFiles=()
for file in ${forCopy[@]}; do
	correctFiles[$counter]="$source${filesArr[$file]}"
	((counter++))
done

destination=$(dialog --title "Select DESTINATION directory" --fselect "" 25 60 --stdout)
destination="$destination/"

if [ $? != 0 ]; then
	finish "Script interrupted"
	clear
	exit 1
fi

if [ ! -d $destination ] || [ -z $destination ]; then
	finish "Choose existing directory."
	clear
	exit 1
fi

if [ $destination = "/" ]; then
	destination=$(pwd)
	destination="$destination/"
fi

counter=1
tmp=0
length=${#correctFiles[@]}
for element in ${correctFiles[@]}; do	
	postep=$(($counter*100/$length))
	tmp=$((counter - 1))
	file_counter=$counter
	((counter++))
	`cp $element $destination`
	echo $postep | dialog --title "Copying" --gauge "Source directory: $source\nDestination directory: $destination\
		\n\nCopying in progress...: $element\n\nFile $file_counter z $length" 12 70
	sleep 1 
done
clear