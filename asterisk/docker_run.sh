#!/bin/sh

cmdrun=$@
cmdname=$0

# Start the first process
nohup asterisk -c >/dev/null 2>&1 & 
status1=$?
if [ $status1 -ne 0 ]; then
  echo "Failed to start asterisk: $status1"
  exit $status1
else
  echo "asterisk run is ok"
fi

# Start the second process
nohup nginx >/dev/null 2>&1 &
status2=$?
if [ $status2 -ne 0 ]; then
  echo "Failed to start nginx: $status2"
  exit $status2
else
  echo "nginx run is ok"
fi

# Start the third process
nohup php-fpm >/dev/null 2>&1 & 
status3=$?
if [ $status3 -ne 0 ]; then
  echo "Failed to start php-fpm: $status3"
  exit $status3
else
  echo "php-fpm run is ok"
fi

# Start the firstly process
nohup $cmdrun >/dev/null 2>&1 &
status4=$?
if [ $status4 -ne 0 ]; then
  echo "Failed to start cmdrun: $status4"
  exit $status4
else
  echo "cmdrun run is ok"
fi

while sleep 60; do
  ps aux | grep asterisk | grep -q -v grep
  PROCESS_1_STATUS=$?
  ps aux | grep nginx | grep -q -v grep
  PROCESS_2_STATUS=$?
  ps aux | grep php-fpm | grep -q -v grep
  PROCESS_3_STATUS=$?
  ps aux | grep $cmdname | grep -q -v grep
  PROCESS_4_STATUS=$?
  # If the greps above find anything, they exit with 0 status
  # If they are not both 0, then something is wrong
  if [ $PROCESS_1_STATUS -ne 0 -o $PROCESS_2_STATUS -ne 0 -o $PROCESS_3_STATUS -ne 0 -o $PROCESS_4_STATUS -ne 0 ]; then
	echo "One of the processes has already exited."
	exit 1
  fi
done
