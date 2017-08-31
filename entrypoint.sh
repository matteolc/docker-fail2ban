#!/bin/bash
set -e

[[ ${DEBUG} == true ]] && set -x

# default behaviour is to launch fail2ban
if [[ -z ${1} ]]; then

    echo "Cleaning up.."
    service fail2ban stop
    rm -f /var/run/fail2ban/*
    echo "Starting fail2ban.."
    service fail2ban start
    tail -f /var/log/fail2ban.log

else
  exec "$@"
fi



