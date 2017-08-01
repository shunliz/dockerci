#!/bin/bash
set -e

export RBD_DOCKER_PLUGIN_DEBUG=1

/opt/bin/rbd-docker-plugin \
--create \
--size=1024
