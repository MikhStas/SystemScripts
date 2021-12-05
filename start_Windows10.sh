#! /bin/bash

#Check swap size and if it's enough start VM Windows 10
actual_swap_size=$(free --giga | grep Swap | awk '{print $2}')
expected_swap_size=10
is_ready=0

if [ $actual_swap_size -ge $expected_swap_size ]
then
	echo "Found enough swap size" && is_ready=1
else
	echo "Not enough swap size ($actual_swap_size Gi), trying to connect swap on /dev/sdb2...";
	sudo swapon /dev/sdb2 && is_ready=1 && echo "Success!"
fi

if [ $is_ready -eq 1 ]
then
	echo "Starting Windows 10...";
	virsh start Windows10 &&
	echo "Preparing windows.." &&
	virt-manager --connect qemu:///system --show-domain-console Windows10 &&
	echo "Done!"
else
	echo "Windows 10 can not be started!"
fi
