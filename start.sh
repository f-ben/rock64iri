#!/bin/sh

echo "Starting docker container..."
echo "Using ports 14265/tcp 14600/udp 15600/tcp"
echo "Using volume /mnt/usb/rock64iri/data"
echo "-"
docker run --restart always --name iri -d -p 14265:14265 -p 14600:14600/udp -p 15600:15600 -v /mnt/usb/rock64iri/data:/data fben/rock64iri:1.6.1-RELEASE