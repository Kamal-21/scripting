#!/bin/bash

alert="\033[1;36m"
success="\033[1;32m"
warning="\033[1;33m"
error="\033[1;31m"
nocolour="\033[00m"

if [[ $EUID -eq 0 ]];then
    if [[ -f /home/kamal/downloads0.1/latest.zip ]];then
    echo -e $alert File Already Exist $nocolour

    elif [[ ! -f /home/kamal/downloads0.1/latest.zip ]];then
    echo -e $warning Do You Want to Install Wordpress?{Yes[Y] , No[N]} $nocolour
    read answer
        if [[ $answer == Y ]];then
        wget https://wordpress.org/latest.zip -o /home/kamal/downloads0.1/latest.zip    
        echo -e $success File Downloaded Successfully $nocolour 

            if [[ -f /home/kamal/downloads0.1/latest.zip ]];then
            unzip -q -d /var/www/html/ latest.zip
            echo -e $success Extraction successfull $nocolour

                if [[ -d /var/www/html/wordpress ]];then
                chmod -R 750 /var/www/html/wordpress
                echo -e $success Permission Granted $nocolour
                else
                echo -e $error Permission Denied $nocolour
                fi
                
            else 
            echo -e $error Unzip Failed $nocolour
            fi
        else
        Exit
        fi
    fi
else 
echo -e $warning Run in sudo privilege $nocolour
fi