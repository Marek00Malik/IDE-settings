#!/bin/bash
###########################################################################
## This script is responsible for syncing idea configs between enviroments Linux and MacOs to Google Drive cloud.
###########################################################################


set -e
CES_GOGLE_DRIVE='/Software/IDEA/ces/';
CES_LINUX="$HOME/Pulpit/GitCode/Statoil/engage/.idea/runConfigurations";
CES_OSX='';

FES_GOGLE_DRIVE='/Software/IDEA/fes/';
FES_LINUX="$HOME/Pulpit/GitCode/Statoil/fuel-e-service/.idea/runConfigurations";
FES_OSX='';

INGO_GOGLE_DRIVE='/Software/IDEA/ingo/';
INGO_LINUX="$HOME/Pulpit/GitCode/Statoil/ingo/.idea/runConfigurations";
INGO_OSX='';

EXTRA2_GOOGLE_DRIVE='/Software/IDEA/extra/';
EXTRA2_LINUX="$HOME/Pulpit/GitCode/Statoil/extra2/.idea/runConfigurations";
EXTRA2_OSX='';

params="<from|to>"
OS_SYSTEM='unknown'

if [[ $OSTYPE == *"linux"* ]]; then
    OS_SYSTEM='Linux'
    GOOGLE_DRIVE="$HOME/Google Drive"
elif [[ $OSTYPE == 'macos' ]]; then
    OS_SYSTEM='MacOs'  
    GOOGLE_DRIVE="$HOME/Dysk Google" 
fi

echo 
echo 
echo -e "\e[1mSync project configs, runConfiguration files, \e[92mto Google Drive\e[39m or \e[93mfrom Google Drive\e[39m"
echo -e "Running sync on \e[93m$OS_SYSTEM \e[0m"
echo -e "....................................................."
echo 
echo 

function sync_to {
	echo  -e "Copping files from  \e[96m$OS_SYSTEM \e[92mto \e[92mGoogle Drive \e[39m";
    if [[ $OS_SYSTEM == "Linux" ]]; then
        CES="$CES_LINUX"
        FES="$FES_LINUX" 
        INGO="$INGO_LINUX"  
        EXTRA2="$EXTRA2_LINUX"
    elif [[ $OS_SYSTEM == 'MacOs' ]]; then
        CES="$CES_OSX"
        FES="$FES_OSX"   
        INGO="$INGO_OSX"  
        EXTRA2="$INGO_OSX"
    fi

    echo 'CES .....'
	mkdir -p "$GOOGLE_DRIVE$CES_GOGLE_DRIVE" && cp -R $CES "$GOOGLE_DRIVE$CES_GOGLE_DRIVE";

	echo 'FES  ....';
	mkdir -p "$GOOGLE_DRIVE$FES_GOGLE_DRIVE" && cp -R $FES "$GOOGLE_DRIVE$FES_GOGLE_DRIVE";

	echo 'INGO  ...';
	mkdir -p "$GOOGLE_DRIVE$INGO_GOGLE_DRIVE" && cp -R $INGO "$GOOGLE_DRIVE$INGO_GOGLE_DRIVE";

	echo 'EXTRA2 ..';
	mkdir -p "$GOOGLE_DRIVE$EXTRA2_GOOGLE_DRIVE" && cp -R $EXTRA2 "$GOOGLE_DRIVE$EXTRA2_GOOGLE_DRIVE";

    
    echo '-------------------------------------------------'
    echo 'done'
    exit 0
} >&2

function sync_from {
	echo 'Not yet supported - under development';
} >&2

function usage {
    echo "Usage: $0 [-h] [-s ${params}]"
    exit 1
} >&2

if [[ -z "$@" ]]; then
    usage
fi

while getopts "hs:" opt; do
    case $opt in
        h)
			echo "Sync project config files from<=>to OperatingSystem\Google Drive"
            echo
            echo "Options:"
            echo " -h"
            echo "   Print detailed help screen"
            echo " -s <parameter>"
            echo "   ${params}"
            echo
            usage
            ;;
	    s)
            case "$OPTARG" in
            	from)
                    sync_from
                    ;;
 				to)
                    sync_to
					;;
                *)
                    echo 'No parameter selected.'
                    echo 'Choose enviroment: linux, mac_os or google to sync with'
                    ;;
            esac>&2
            ;;
    	?)
            echo ' ??? ??? What do you want ??? ???'
            usage
            ;;
        *)
            echo 'You did not put in anything'
            ;;
    esac >&2

done
