# Docker-test
#
FROM      alpine:edge
MAINTAINER idef1x <docker@sjomar.eu>
ENV VERSION 0.9

RUN apk --no-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community/ add \
    php7 php7-fpm php7-gd php7-session php7-xml nginx curl tar

RUN curl -O -L "http://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz" \
 && mkdir -p /var/www \
 && tar xf /dokuwiki-stable.tgz -C/var/www \
 && mv /var/www/doku* /var/www/html \
 && chown -R nobody. /var/www \
 && rm /dokuwiki-stable.tgz \
 && touch /firstrun

ADD startup.sh /startup.sh
ADD nginx-vhost.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

ENTRYPOINT [ "sh" ]
CMD [ "/startup.sh" ]
