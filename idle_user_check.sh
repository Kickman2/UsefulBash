#!/bin/bash

> users_data.csv
echo "UserName, Latest Login Date, Cron Status" >> users_data.csv

for user in $(awk -F: '$3 >= 1000 {print $1}' /etc/passwd); do
    
    latest_login_date=$(last -n 1 -F $user | awk 'NR==1,OFS="-" {print $8,$5,$6}')
    
    
    if crontab -l -u "$user" 2>/dev/null | grep -q '[0-9]'; then
        cron_status="true"
    else
        cron_status="false"
    fi
    
    echo "$user, $latest_login_date, $cron_status" >> users_data.csv
done


echo "User data has been saved to users_data.csv"