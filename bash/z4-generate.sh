#!/usr/bin/bash

`touch endlessScript.pid`
echo "$$" > endlessScript.pid
while :
do
	sleep 1
done

