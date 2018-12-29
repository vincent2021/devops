#!/bin/bash

OLDSUM=`cat /var/lib/cron.md5`
NEWSUM=`md5sum /etc/crontab`

if [ "$OLDSUM" != "$NEWSUM" ]
then
	md5sum /etc/crontab > /var/lib/cron.md5
  echo "WARNING - CONNECT TO YOUR SERVER NOW TO CHECK CRON JOBS" | mail -s "The file crontab was modified" root@localhost
fi
