#!/bin/bash

alert="\033[1;36m"
success="\033[1;32m"
warning="\033[1;33m"
error="\033[1;31m"
nocolour="\033[00m"

if [[ -d /home/kamal/downloads0.1 ]];then
echo -e $alert Directory Exists $nocolour
else 
mkdir -p /home/kamal/downloads0.1 
echo Directory Created
fi
 
if [[ -f /home/kamal/downloads0.1/latest.zip ]];then
echo -e $alert File Already Exist $nocolour
else 
wget https://wordpress.org/latest.zip -o /home/kamal/downloads0.1/latest.zip
echo -e $success File Downloaded Successfully $nocolour
fi
