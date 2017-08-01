# ceph-docker-cli

Run ceph in docker

## Prerequisites

 * docker
 * etcd2 cluster at localhost listening 2379
 * raw disk at /dev/sdc

## Populate kv store in etcd (Only needs to execute this once)

    ./populate-kv.sh
    etcdctl set /ceph-config/ceph/client/rbd_default_features 1

## Create directories

    ./populate-dir.sh

## Install ceph cli for docker

    ./ceph-install.sh

## Start ceph mon ( Needs at least 3 nodes to bootstrap a cluster)

    ./create-ceph-mon.sh $HOST_IP(e.g. 192.168.1.10) $CEPH_PUBLIC_NETWORK(e.g. 192.168.1.0/24)

## Start ceph osd (Should execute this after the mon cluster has been bootstrapped)

    ./create-ceph-osd.sh
