#!/usr/bin/bash

function create() {
	action=$1
	echo -n "[Creating $1] specify name(s): "
	read -a arg_list
	for element in "${arg_list[@]}"; do
		if [ $action = "file" ]; then
		`touch $element`
	elif [ $action = "directory" ]; then
		`mkdir -p $element`
		fi

	done
	echo ""
}

function delete() {
	echo -n "[deleting] specify name(s): "
	read -a delete_me
	for element in "${delete_me[@]}"; do
		`rm -r $element `
	done
	echo ""
}

function cpmv() {
	read -p "[$1] specify two argumantes separated by space [SOURCE DESTINATION]: " source destination
	`$1 $source $destination`

}

printf "Script 1.2\n-----------------\n"
select numer in "create file" "create directory" delete copy move exit
do
	case $numer in
		"create file")
			create "file";;
		"create directory")
			create "directory";;
		delete)
			delete;;
		copy)
			cpmv "cp";;
		move)
			cpmv "mv";;
		exit)
			exit 1
			break;;
		*)
			printf "Unknown option, try again.\n\n"
	esac
done
