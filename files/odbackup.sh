#!/bin/sh 
#set -xv; exec 1>>/tmp/out 2>&1 
PATH=/bin:/usr/bin:/sbin:/usr/sbin export PATH 
FILE="/tmp/sacommands.txt" 
LOCATION=/Volumes/BackupHD/OpenDirectory/`date "+%Y_%m_%d"` 
LOGS="/tmp/logs.txt" 
mkdir -p /Volumes/BackupHD/OpenDirectory 
find /Volumes/BackupHD/OpenDirectory* -mtime +6 -exec rm -rf {} \; 
echo "dirserv:backupArchiveParams:archivePassword = <yourpassword>" > $FILE 
echo "dirserv:backupArchiveParams:archivePath = $LOCATION" >> $FILE 
echo "dirserv:command = backupArchive" >> $FILE 
serveradmin command < $FILE 
echo "To: admin@wherever.com" > $LOGS 
echo "From: Server Daily Report <server@wherever.com>" >> $LOGS 
echo "Subject: Daily ODM Backup Report" - `date` >> $LOGS 
echo "The Open Directory Master at `hostname` has been successfully 
backed up. It's location is $LOCATION and will be available for seven 
days. After seven days, the archive will be deleted." >> $LOGS 
cat $LOGS | sendmail -f admin@wherever.com -t 
#rm -rf $FILE 
#rm -rf $LOGS
