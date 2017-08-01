#!/bin/bash

NEXUS_NAME=${NEXUS_NAME:-nexus}
NEXUS_VOLUME=${NEXUS_VOLUME:-nexus-volume}

if [ -n "$(docker ps -a | grep ${NEXUS_NAME})" ]; then
docker stop ${NEXUS_NAME}
docker rm -v ${NEXUS_NAME}

#Docker volume won't be deleted by default
#to avoid misoperation.
#
#docker rm -v ${NEXUS_VOLUME}
fi
