#!/bin/bash
set -e

docker run --rm --privileged=true \
-v /dev/:/dev/ \
-e OSD_DEVICE=/dev/sdc \
ceph/daemon:tag-build-master-jewel-ubuntu-16.04 zap_device
