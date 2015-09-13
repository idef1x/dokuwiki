# Docker-test
#
# VERSION               0.1

FROM      ubuntu:14.04
MAINTAINER idef1x <docker@sjomar.eu>

ENV DEBIAN_FRONTEND noninteractive


RUN apt-get update && apt-get dist-upgrade -y
RUN apt-get install -y \
	apache2 \
	php5 \
	php5-gd \
	wget


RUN wget http://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz
RUN rm -rf /var/www/html
RUN tar xf /dokuwiki-stable.tgz -C/var/www
RUN mv /var/www/doku* /var/www/html
RUN chown -R www-data.www-data /var/www
RUN rm /dokuwiki-stable.tgz

RUN a2enmod rewrite
ADD 000-default.conf /etc/apache2/sites-available/000-default.conf
ADD startup.sh /startup.sh
RUN chmod +x /startup.sh

# Cleanup
RUN apt-get clean

EXPOSE 80

ENTRYPOINT [ "/startup.sh" ]

