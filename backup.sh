#!/bin/sh

export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
MOUNT_PATH=/mnt/cifs
DT=`date +%y%m%d_%H%M%S`

mount -t cifs //192.168.1.232/omv_backup_share $MOUNT_PATH -o user=omv_backup,password=Ftp4om12
if [ $? -ne 0 ]
then
	echo "mount failed, exiting..."
	exit
fi

tar -cf $MOUNT_PATH/omv_$DT.txz --one-file-system /
if [ $? -ne 0 ]
then
	echo "tar failed =("
fi

umount $MOUNT_PATH
