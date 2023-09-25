#!/bin/bash

#Directory + copies the file with the current date
cp /var/log/syslog "syslog_$(date '+"%d-%m-%Y"').log"

#Message presented in the terminal to the user
echo "File syslog_$(date '+"%d-%m-%Y"').log has been created!"
