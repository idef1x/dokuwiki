# Docker-test
#
FROM      alpine:edge
MAINTAINER idef1x <docker@sjomar.eu>
ENV VERSION 0.9

# Installing packages
RUN apk --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ add \
    php7 php7-fpm php7-gd php7-session php7-xml php7-openssl php7-zip php7-zlib nginx curl tar zip

# Download & configure
RUN curl -O -L "http://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz" \
 && mkdir -p /var/www \
 && tar xf /dokuwiki-stable.tgz -C/var/www \
 && mv /var/www/doku* /var/www/html \
 && chown -R nobody. /var/www \
 && rm /dokuwiki-stable.tgz \
 && sed -i "s/upload_max_filesize\ \=\ 2M/upload_max_filesize\ \=\ 100M/g" /etc/php7/php.ini \
 && sed -i "s/post_max_size\ \=\ 8M/post_max_size\ \=\ 100M/g" /etc/php7/php.ini \
 && touch /firstrun

ADD startup.sh /startup.sh
ADD nginx-vhost.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

ENTRYPOINT [ "sh" ]
CMD [ "/startup.sh" ]
