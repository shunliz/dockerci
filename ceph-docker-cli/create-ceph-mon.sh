#!/bin/bash
set -e

HOST_IP=$1
CEPH_PUBLIC_NETWORK=$2
CLUSTER_NAME=$3
ETCD_CLIENT_IP=$4

docker run -d --net=host --name=ceph-mon-${HOSTNAME} \
--restart=unless-stopped \
-v /etc/ceph:/etc/ceph \
-v /etc/ganesha:/etc/ganesha \
-v /var/lib/ceph:/var/lib/ceph \
-v /etc/localtime:/etc/localtime:ro \
-e MON_IP=${HOST_IP} \
-e CEPH_PUBLIC_NETWORK=${CEPH_PUBLIC_NETWORK} \
-e CLUSTER=${CLUSTER_NAME:-ceph} \
-e KV_TYPE=etcd \
-e KV_IP=${ETCD_CLIENT_IP:-127.0.0.1} \
-e KV_PORT=2379 \
ceph/daemon:tag-build-master-jewel-ubuntu-16.04 mon
