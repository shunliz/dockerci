#!/bin/bash
set -e

CLUSTER_NAME=$1
ETCD_CLIENT_IP=$2

docker run -d --net=host --name=ceph-osd-${HOSTNAME} \
--restart=unless-stopped \
--privileged=true \
--pid=host \
-v /dev/:/dev/ \
-v /var/lib/ceph:/var/lib/ceph \
-v /etc/localtime:/etc/localtime:ro \
-e OSD_DEVICE=/dev/sdc \
-e CLUSTER=${CLUSTER_NAME:-ceph} \
-e KV_TYPE=etcd \
-e KV_IP=${ETCD_CLIENT_IP:-127.0.0.1} \
-e KV_PORT=2379 \
ceph/daemon:tag-build-master-jewel-ubuntu-16.04 osd_ceph_disk
