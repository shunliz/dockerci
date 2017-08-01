# docker-ceph-plugin-cli

## Install ceph driver
sudo mkdir -p /opt/bin
./install-rbd-docker-plugin.sh

## Test plugin
sudo ./start-volume-plugin.sh
## start another console
./test-volume-plugin.sh v01

## Install rbd-docker-plugin service
sudo cp docker-ceph-plugin-cli/rbd-docker-plugin.service /lib/systemd/system/
sudo systemctl enable rbd-docker-plugin
sudo systemctl start rbd-docker-plugin
sudo systemctl status rbd-docker-plugin
