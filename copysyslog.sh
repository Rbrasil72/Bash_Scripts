#!/bin/bash

#Diretorio + copia do ficheiro com
cp /var/log/syslog "syslog_$(date '+"%d-%m-%Y"').log"

echo "File syslog_$(date '+"%d-%m-%Y"').log has been created!"