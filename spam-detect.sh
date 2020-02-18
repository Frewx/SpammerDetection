## Written by Hikmet Ugur Akgul
## hikmetugurakgul@gmail.com
## Postfix Spam Check And Delete Script
## Version: 1.0.0


#!/bin/bash

sender=$(/usr/sbin/postqueue -p | grep \! |  /bin/awk '{print $7}')

echo "$sender" > /tmp/spammer.txt

spammers=$(cat /tmp/spammer.txt | awk '{print $1}' | sort | uniq -c | sort -nr | awk '$1' > 200) ## 200 is the sender's threshold.

echo "$spammers" > /tmp/spammer.sorted

cat /tmp/spammer.sorted | awk '{print $2}' | while read line
do
  	/root/Scripts/postfix-delete.pl $line
done
