#!/bin/bash
if [ ! -d /data ]
  then 
    echo "No /data found so assuming you've set up your own persistent volumes (-v </<dir> or --volumes-from <data container> ) or don't want it "
  else
    if `ls -A /data`
     then 
       echo "Clean install apparently"
       mv /var/www/html /data
       # Set ownership of www dir to www-data
       chown -R www-data.www-data /data
       ln -s /data /var/www/html
     else
       rm -rf /var/www/html
       ln -s /data /var/www/html 
    fi
fi

# start Apache 
/etc/init.d/apache2 start

# to keep container alive keep this shell open:
tail -f /var/log/dmesg

