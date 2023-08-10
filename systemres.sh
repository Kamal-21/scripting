#!/bin/bash

alert="\033[1;36m"
success="\033[1;32m"
warning="\033[1;33m"
error="\033[1;31m"
nocolour="\033[0m"
GREEN='\033[32m'
FGCOLOR_RED='\033[31m'
BGCOLOR_RED='\033[41m'
white_space="\r\033[K"

loading_text="System Resources Loading..."
animation_chars=("-" "\\" "|" "/")
delay=0.1  # Adjust this value to control the speed of animation
duration=4  # Adjust this value to control how long the animation runs

clear

end_time=$((SECONDS + duration))
while [ $SECONDS -lt $end_time ]; do
    for ((i = 0; i < ${#loading_text}; i++)); do
        echo -n -e "\r${warning}${loading_text:0:i}${animation_chars[i % ${#animation_chars}]}${loading_text:i+1}${nocolour}"
        sleep ${delay}
    done
done

echo -e "${white_space}${alert}${BGCOLOR_RED} System Resourses ${nocolour}${nocolour}"

echo 
echo -e $success OS name : $nocolour
hostnamectl |grep 'Operating System' | awk '{print $3,$4,$5}'
echo 
echo -e $success Hostname : $nocolour
hostname
echo
echo -e $success IP Address $nocolour
echo -e $success Private : $nocolour
ip addr show | awk '/inet / {split($2, a, "/"); if (a[1] ~ /^10\.|^172\.(1[6-9]|2[0-9]|3[0-1])\.|^192\.168\./) print a[1]} '

echo
echo -e $success Public : $nocolour
curl -s icanhazip.com -4
echo
echo -e $success Ram : $nocolour
free -h | grep -v 'Swap' | awk 'NR == 1 {printf "%8s %8s %8s %10s\n", $1, $2, $3, $6} NR > 1 {printf "%8s %8s %8s %10s\n", $2, $3, $4, $7}'

echo 
echo -e $success Storage : $nocolour
df -hT / | awk '{printf "%8s %8s %8s\n", $3, $4, $5}'