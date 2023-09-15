#!/bin/bash
zone=$(logname)
/usr/sbin/rndc freeze ${zone}.lab-eni.fr
/usr/sbin/rndc sync -clean ${zone}.lab-eni.fr
sed -i -E '/SOA/ N;s/(\n[^0-9]+)[0-9]+/\1'"$(grep -A 1 'SOA' ${zone} | awk  '/^\t/ {print $1+1}')"'/' ${zone}
chown ${zone} ${zone}
su ${zone} -c "vim $(logname)"
zone="$(logname)"
if /usr/sbin/named-checkzone ${zone}.lab-eni.fr /var/cache/bind/${zone} ; then
	/usr/sbin/rndc reload ${zone}.lab-eni.fr
	/usr/sbin/rndc thaw ${zone}.lab-eni.fr
else
	echo "erreur dans votre zone... relancer la procédure"
fi

