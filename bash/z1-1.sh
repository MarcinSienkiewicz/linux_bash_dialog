#!/usr/bin/bash

<<BANNER
-fc; file create
-dc; directory create
-copy; copy
-del; delete
-mov; move
BANNER

arguments=$#

# number of arguments check
if [ $arguments -lt 2 ]; then	
	echo "At least two arguments in CLI required."
	echo "[code] path"
	exit 1
fi

# codes check
if ! [[ "$1" =~ ^(-fc|-dc|-copy|-del|-mov)$ ]]; then
	echo "Unknon argument"
	exit 1
fi

# creating files and folders
if [[ "$1" =~ ^(-dc|-fc)$ ]] && [[ $# -ge 2 ]]; then
	if [[ $1 = "-fc" ]]; then
		action="touch "
	elif [[ $1 = "-dc" ]]; then
		action="mkdir -p"
	fi

	for((i=2; i<=$arguments; i++)); do
		`$action ${!i}`		
	done
fi

# deleting files and folders
if [[ $1 = "-del" ]] && [[ $# -ge 2 ]]; then
	for((i=2; i<=$arguments; i++)); do
		`rm -r ${!i}`
	done	
fi

# copy and move
if [[ "$1" =~ ^(-copy|-mov)$ ]] && [[ $# -lt 3 ]]; then	
	echo "SOURCE and DESTINATION spearated by space required in CLI."
	echo "Example: $0 $1 someFile.txt home/backup"
	exit 1

elif [[ "$1" =~ ^(-copy|-mov)$ ]] && [[ $# -ge 3 ]]; then
	if [[ $1 = "-copy" ]]; then
		operation="cp"
	elif [[ $1 = "-mov" ]]; then
		operation="mv"
	fi

	cel="${@:$#}"
	if ! [[ -d $cel ]]; then		
        echo "Both copy and move require the last argument to be a folder."
		exit 1
	fi
	ile=$(($# - 2))
	elements_list="${@:2:$ile}"
	for element in $elements_list; do
		`$operation $element $cel`
	done
	exit 1
fi
