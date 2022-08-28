#!/usr/bin/bash

FL=endlessScript.pid


if [ -f "$FL" ] && [ -s $FL ]; then
	read -r pid < endlessScript.pid
	`:>$FL`
	kill -SIGKILL $pid

else
	echo "File '$FL' doesn't exist or is empty."
	exit 1
fi
echo "PID '$pid' killed."
