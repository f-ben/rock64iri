#!/bin/sh

ROCK64IRI=/mnt/usb/rock64iri
ROCK64IRIDATA=$ROCK64IRI/data
APIPORT=14265
UDPPORT=14600
TCPPORT=15600

echo "Starting docker container..."
echo "-"
echo "Using ports $APIPORT/tcp $TCPPORT/tcp $UDPPORT/udp"
echo "Using volume $ROCK64IRIDATA"
echo "-"
echo "This file should only be used for the initial setup."
echo "If you already created your IRI container, please use"
echo "./start.sh"
echo "instead. Starting container, please wait..."
echo "-"
docker run -d --restart always --name iri \
           -p $APIPORT:$APIPORT \
           -p $UDPPORT:$UDPPORT/udp \
           -p $TCPPORT:$TCPPORT \
           -v $ROCK64IRIDATA:/data \
           fben/rock64iri:1.6.1-RELEASE
