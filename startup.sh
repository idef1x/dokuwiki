#!/bin/bash
if [ -f /firstrun ]
  then
    rm /firstrun
    if [ ! -d /data ]
      then 
        echo "No /data found so assuming you've set up your own persistent volumes (-v </<dir> or --volumes-from <data container> ) or don't want it "
      else
        if `ls -A /data`
          then 
            echo "Clean install apparently"
            cp -dpr /var/www/html/* /data/
       	    cp -dpr /var/www/html/.* /data/
            rm -rf /var/www/html
            # Set ownership of www dir to www-data
            chown -R www-data.www-data /data
            ln -s /data /var/www/html
          else
            rm -rf /var/www/html
            ln -s /data /var/www/html 
        fi
    fi
fi

# start Apache 
source /etc/apache2/envvars && exec /usr/sbin/apache2 -DFOREGROUND

