#!/bin/bash

#Diretorio + copia do ficheiro com a data do dia atual
cp /var/log/syslog "syslog_$(date '+"%d-%m-%Y"').log"

#Mensagem apresentada na terminal ao utilizador
echo "File syslog_$(date '+"%d-%m-%Y"').log has been created!"
