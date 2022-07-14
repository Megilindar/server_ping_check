#!/bin/bash

email=yourmail@domain.com
NBR_DOWN=0
LOGFILE=/tmp/pinglog.txt

echo "Ping  Results" > $LOGFILE
for i in $(cat /root/server_list.txt); do
    fping $i >/dev/null
    if [ $? -ne 0 ]; then
        echo "$i is down" >> $LOGFILE
        NBR_DOWN=$((NBR_DOWN+1))
    fi
done

if [ $NBR_DOWN -gt 0 ]; then
    mailx -s "Some servers down!!" $email < $LOGFILE
fi
