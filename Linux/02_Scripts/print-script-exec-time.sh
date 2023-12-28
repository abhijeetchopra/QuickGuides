#!/bin/bash

SCRIPT_START_TIMESTAMP=$(date +"%Y-%m-%d %I:%M:%S %p")
SCRIPT_START_TIME_EPOCH="$(date +%s)"

DELAY=2
printf "Enter delay in seconds: "
read DELAY
echo ""
for (( i=1; i<=$DELAY; i++))
do
  echo $i;
  sleep 1
done

# print script execution time
SCRIPT_END_TIMESTAMP=$(date +"%Y-%m-%d %I:%M:%S %p")
SCRIPT_END_TIME_EPOCH="$(date +%s)"
SCRIPT_EXEC_TIME=$[ ${SCRIPT_END_TIME_EPOCH} - ${SCRIPT_START_TIME_EPOCH} ]
echo ""
echo -e "Started   : $SCRIPT_START_TIMESTAMP"
echo -e "Completed : $SCRIPT_END_TIMESTAMP"
# print script execution time in human readable format (HH:MM:SS)
printf 'Total     : %02dh:%02dm:%02ds\n' $((SCRIPT_EXEC_TIME/3600)) $((SCRIPT_EXEC_TIME%3600/60)) $((SCRIPT_EXEC_TIME%60))