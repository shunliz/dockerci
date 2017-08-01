#!/bin/bash
set -e

docker run --rm \
-v /opt/bin:/opt/bin \
ceph/install-utils
