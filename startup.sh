#!/bin/bash
if [ -f /firstrun ]
  then
    # Create nginx run dir, since it doesn't exist on start
    mkdir -p /run/nginx
    chown -R nginx. /run/nginx
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
        fi
        rm -rf /var/www/html
        # Set ownership of www dir to nobody 
        chown -R nobody. /data
        ln -s /data /var/www/html
    fi
fi

# start nginx
/usr/sbin/php-fpm7
nginx -g "daemon off;"

