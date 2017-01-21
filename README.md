# dokuwiki
Dokuwiki WiKi Docker image based on alpine and nginx 

- in case of persistent storage: please mount it at /data in the container. See example startup.

Example startup:
```
docker run -d \
  -v /etc/localtime:/etc/localtime:ro \
  -v /etc/timezone:/etc/timezone:ro \
  -v <path on host for data>:/data \
  --name dokuwiki -h <FQDN> \
  -p 80:80 \
  idef1x/dokuwiki
```

# Initial set-up
Goto http://<hostip>/install.php
- fill in the required settings
