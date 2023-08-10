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

# Check if Brave is already installed
brave_installed=$(dpkg-query -W -f='${Status}' brave-browser 2>/dev/null | grep -c "installed")

# Installation animation parameters
loading_text1="Installing Brave..."
animation_chars=("-" "\\" "|" "/")
delay=0.1
duration=4


end_time=$((SECONDS + duration))

if [ "$brave_installed" -eq 1 ]; then
    echo -e "${warning}Brave is already installed.${nocolour}"
else
    echo -e "${warning}Do You Want To Install BRAVE? (Y/N)${nocolour}"
    read -r y

    if [[ "$y" == "Y" || "$y" == "y" ]]; then
        while [ $SECONDS -lt $end_time ]; do
            for ((i = 0; i < ${#loading_text1}; i++)); do
                echo -n -e "\r${warning}${loading_text1:0:i}${animation_chars[i % ${#animation_chars}]}${loading_text1:i+1}${nocolour}"
                sleep ${delay} 
            done
        done
        curl -q -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg 
        echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | tee /etc/apt/sources.list.d/brave-browser-release.list > /dev/null
        apt update > /dev/null 2>&1
        apt install brave-browser -y > /dev/null 2>&1
        echo -e "${white_space}${GREEN}${BGCOLOR_RED} Brave Installed Successfully ${nocolour}${nocolour}"
    fi
fi

# Check if AnyDesk is already installed
anydesk_installed=$(dpkg-query -W -f='${Status}' anydesk 2>/dev/null | grep -c "installed")
# Installation animation parameters
loading_text2="Installing AnyDesk..."
animation_chars=("-" "\\" "|" "/")
delay=0.1
duration=4

end_time=$((SECONDS + duration))

if [ "$anydesk_installed" -eq 1 ]; then
    echo -e "${warning}AnyDesk is already installed.${nocolour}"
else
    echo -e "${warning}Do You Want To Install ANYDESK? (Y/N)${nocolour}"
    read -r y

    if [[ "$y" == "Y" || "$y" == "y" ]];then
        while [ $SECONDS -lt $end_time ]; do
            for ((i = 0; i < ${#loading_text2}; i++)); do
                echo -n -e "\r${warning}${loading_text2:0:i}${animation_chars[i % ${#animation_chars}]}${loading_text2:i+1}${nocolour}"
                sleep ${delay}
            done
        done
        wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | apt-key add - 
        echo "deb http://deb.anydesk.com/ all main" > /etc/apt/sources.list.d/anydesk-stable.list
        apt update > /dev/null 2>&1
        apt install anydesk -y > /dev/null 2>&1
        echo -e "${GREEN} AnyDesk Installed Successfully ${nocolour}"
    fi
fi
