#!/bin/bash
set -e
GERRIT_NAME=${GERRIT_NAME:-gerrit}
JENKINS_NAME=${JENKINS_NAME:-jenkins}
REDMINE_NAME=${REDMINE_NAME:-redmine}
NEXUS_NAME=${NEXUS_NAME:-nexus}

NGINX_IMAGE_NAME=${NGINX_IMAGE_NAME:-openfrontier/nginx}
NGINX_NAME=${NGINX_NAME:-proxy}
NGINX_MAX_UPLOAD_SIZE=${NGINX_MAX_UPLOAD_SIZE:-200m}

CI_NETWORK=${CI_NETWORK:-ci-network}

# Start proxy
docker run \
    --name ${NGINX_NAME} \
    --net=${CI_NETWORK} \
    -p 80:80 \
    --restart=unless-stopped \
    -e SERVER_NAME=${HOST_NAME} \
    -e CLIENT_MAX_BODY_SIZE=${NGINX_MAX_UPLOAD_SIZE} \
    -d ${NGINX_IMAGE_NAME}
