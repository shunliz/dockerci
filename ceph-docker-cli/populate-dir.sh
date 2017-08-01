#!/bin/bash
set -e

sudo rm -rf /var/lib/ceph
sudo mkdir /var/lib/ceph

sudo rm -rf /etc/ceph
sudo mkdir /etc/ceph

sudo rm -rf /etc/ganesha
sudo mkdir /etc/ganesha

sudo mkdir -p /opt/bin
