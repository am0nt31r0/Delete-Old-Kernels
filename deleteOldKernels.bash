#!/bin/bash

function presentation {

	figlet "Delete Old Kernels" | lolcat

	if [ "$oldKernels" == "" ]
	then	
		echo -e "There aren't any old kernels to delete.\n"
		exit
	fi

	echo -e "$(echo 'CURRENT KERNEL:') $(echo "${GR}$cKernel${NC}")"

	echo -e "OLD KERNELS: ${BL}$oldKernels${NC}\n"
}

function delete_n_update {

	echo -e "${RED}Delete old kernels? [y/n]${NC}"

	until [ "$answer" == "y" -o "$answer" == "n" ]
	do 
		read answer
	done

	if [ "$answer" == "y" ]
	then
		echo -e "\n[${RED}+${NC}] It will be needed to put super user credentials to delete old kernels and update grub...\n\n" 
		sudo apt-get purge $oldKernels
		sudo update-grub2

	elif [ "$answer" == "n" ]
	then
		echo -e "\n\nScript terminated...\n"
	fi

}

function terminate {
	echo -e "${PU}By am0nt031r0${NC}" 
	exit
}

# Colors
PU='\033[0;35m'
BL='\033[1;34m'
GR='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Current and Old Kernels
cKernel=`uname -r`
oldKernels=`dpkg --list | egrep 'linux-image-(extra|[0-9]+)' | awk '{ print $2 }' | sort -V | grep -v $cKernel | xargs`


presentation
delete_n_update
terminate
