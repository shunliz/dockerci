#!/bin/bash
set -e

docker run --detach \
    --hostname ${HOST_NAME} \
    --net ${CI_NETWORK}
    --publish 443:443 --publish 80:80 --publish 8022:22 \
    --name gitlab \
    --restart always \
    --volume /srv/gitlab/config:/etc/gitlab \
    --volume /srv/gitlab/logs:/var/log/gitlab \
    --volume /srv/gitlab/data:/var/opt/gitlab \
    gitlab/gitlab-ce:latest
