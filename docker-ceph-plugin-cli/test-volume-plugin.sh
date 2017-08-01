#!/bin/bash
docker run --rm -it --volume-driver=rbd --volume $1:/mnt/volume alpine /bin/sh
