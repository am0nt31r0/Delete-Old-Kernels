#!/bin/bash

oldKernels=`dpkg --list | egrep 'linux-image-(extra|[0-9]+)' | awk '{ print $2 }' | sort -V | grep -v $(uname -r) | xargs`
cKernel=`uname -r`
made="By Ubik"


echo "+++++SCRIPT TO DELETE OLD KERNELS+++++"

if [ "$oldKernels" == "" ]
then	
	echo "There aren't any old kernels to delete."
	echo $made
	exit
fi

echo ""
echo "****************************************"
echo "CURRENT KERNEL: $cKernel"
echo "****************************************"

echo ""
echo "****************************************"
echo "OLD KERNELS: $oldKernels"
echo "****************************************"

echo ""
echo "Delete old kernels? [y/n]"
until [ "$answer" == "y" -o "$answer" == "n" ]
do 

	read answer

done

echo ""

if [ "$answer" == "y" ]
then

	sudo apt-get purge $oldKernels
	echo ""
	echo "Update do Grub:"
	sudo update-grub2

elif [ "$answer" == "n" ]
then

	echo "Script terminated..."
fi

echo $made
exit

