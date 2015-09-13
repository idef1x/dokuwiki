# dokuwiki
Dokuwiki WiKi Docker image based on Ubuntu

- in case of persistent storage: please mount it at /data in the container. See example startup.

Example startup:
```
docker run -d \
  -v /etc/localtime:/etc/localtime:ro \
  -v /etc/timezone:/etc/timezone:ro \
  -v <path on host for data>:/data \
  --name dokuwiki -h <FQDN> \
  idef1x/dokuwiki
```
