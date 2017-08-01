#!/bin/bash
docker run --rm -v /opt/bin:/tmp/plugin thinkernel/rbd-docker-plugin cp /go/bin/rbd-docker-plugin /tmp/plugin/rbd-docker-plugin
