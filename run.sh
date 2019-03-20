#!/bin/sh

ROCK64IRI=/mnt/usb/rock64iri
ROCK64IRIDATA=$ROCK64IRI/data
ROCK64IRISNAP=$ROCK64IRI/snapshots

echo "Starting docker container..."
echo "-"
echo "Using ports 14265/tcp 14600/udp 15600/tcp"
echo "Using volume $ROCK64IRIDATA"
echo "Using volume $ROCK64IRISNAP"
echo "-"
echo "This file should only be used for the initial setup."
echo "If you already created your IRI container, please use"
echo "./start.sh"
echo "instead. Starting container, please wait..."
echo "-"
docker run -d --restart always --name iri \
           -p 14265:14265 \
           -p 14600:14600/udp \
           -p 15600:15600 \
           -v $ROCK64IRIDATA:/data \
           -v $ROCK64IRISNAP/mainnet.snapshot.meta:/snapshots/mainnet.snapshot.meta \
           -v $ROCK64IRISNAP/mainnet.snapshot.state:/snapshots/mainnet.snapshot.state \
           -v $ROCK64IRISNAP/spent-addresses-db:/snapshots/spent-addresses-db \
           fben/rock64iri:1.6.1-RELEASE
