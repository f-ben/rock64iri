#!/bin/sh
echo "Stopping docker..."
sudo systemctl stop docker
echo "Redirecting docker to external drive..."
sudo mv /var/lib/docker /mnt/usb/docker
sudo ln -s /mnt/usb/docker /var/lib/docker
sudo chown -R root:root /mnt/usb/docker
echo "Starting docker..."
sudo systemctl start docker
echo "Finished"
