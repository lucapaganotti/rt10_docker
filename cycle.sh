#!/bin/bash

CMD='docker run -d --rm --net host --name rt10 rt10'
BIN='rt10'

while [ true ]
do
	$CMD > /dev/null 2>&1
	result=$?
	echo "$BIN exit code: $result"
        if [ $result -eq 0 ]
	then
		sleep 780
	else
		echo "another $BIN instance currently running, wait 60 s ..."
		sleep 60
	fi
done
