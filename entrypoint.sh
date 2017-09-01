#!/bin/bash
set -e

[[ ${DEBUG} == true ]] && set -x
PIDFILE="/var/run/${APP}/${APP}.pid"

# default behaviour is to launch fail2ban
if [[ -z ${1} ]]; then

    service monit start
    monit start ${APP}        
    tail -f /var/log/${APP}.log    

else
  exec "$@"
fi





