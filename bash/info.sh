#!/usr/bin/bash

function hdd() {
	echo "HDD info - free space"
	echo "-----------------------------"
	exec df -h --total --output=source,avail
}

function ram() {
	echo "Free RAM info"
	echo "---------------------------"
	exec cat /proc/meminfo | grep "MemFree"
}

function cpu() {
	echo "CPU info"
	echo "--------"
	echo -n "Number of CPUs: "; nproc
	echo ""
	exec cat /proc/cpuinfo | grep -E "model|MHz|cores"
}


if [ $# -ne 1 ]; then
	echo "Incorrect number of parameters."
elif ! [[ "$1" =~ ^(-hd|-ram|-k|-cpu|-all)$ ]]; then
	echo "Unknown parameter."
elif [ $1 = "-hd" ]; then
	hdd
elif [ $1 = "-ram" ]; then
	ram
elif [ $1 = "-cpu" ]; then
	cpu
elif [ $1 = "-all" ]; then
	cpu
	echo; echo
	ram
	echo; echo
	hdd
fi
