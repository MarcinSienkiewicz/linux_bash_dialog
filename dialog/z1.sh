#!/bin/bash

f_name=""; l_name=""; email=""; login=""; pass=""; hobby=""

dane=$(dialog --clear "$@"--separator "*" --title "Questionnaire" \
	--backtitle "Person form" --mixedform "Please enter below" 15 50 0 \
	"First Name:" 1 1 "$f_name" 1 12 30 0 0\
	"Last Name:" 2 0 "$l_name" 2 12 30 0 0\
	"Email:" 3 0 "$email" 3 12 30 0 0\
	"Login:" 4 1 "$login" 4 12 30 0 0\
	"Password:" 5 1 "$pass" 5 12 30 0 1\
	"Hobby:" 6 1 "$hobby" 6 12 30 0 0 --output-fd 1)

if [ $? = 0 ]; then
	path=$(dialog --title "Select path" --fselect "" 15 50 --stdout)	
	if [ -d $path ]; then
		dialog --title "Error" --msgbox "Specify write-to file." 5 40
	else
		echo "$dane" >> $path
		dialog --title "Success" --infobox "Data saved." 4 20; sleep 2
	fi
else
	dialog --title "Error" --msgbox "Data NOT saved" 5 30
		
fi
clear
