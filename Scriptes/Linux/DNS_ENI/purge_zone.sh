#!/bin/bash

cp -a /var/cache/bind /root/BACKUP
cp -a /etc/bind/zone.lab-eni.fr.conf /root/BACKUP
cp -a /etc/bind/zone.lab-eni.fr.conf.d /root/BACKUP

for file in $(find /var/cache/bind -type f -regextype posix-egrep -regex '.*-[0-9]+' 2> /dev/null | awk -F "/" '{print $NF}') ; do
    if [[ -f /var/cache/bind/$file ]] ;  then
        rm /var/cache/bind/$file
    fi
    if [[ -f /var/cache/bind/$file.jnl ]] ;  then
        rm /var/cache/bind/$file.jnl
    fi
    if [[ -f /etc/bind/zone.lab-eni.fr.conf.d/$file.conf ]] ;  then
        rm /etc/bind/zone.lab-eni.fr.conf.d/$file.conf
    fi
    sed -i  "/$file\./d" /etc/bind/zone.lab-eni.fr.conf
done
cat /tmp/zone.lab-eni.fr.conf

rndc reload
