#!/bin/sh
DATA=./data
SNAP=./snapshots
echo "Stopping IRI container..."
./stop.sh
echo "Deleting old database..."
sudo rm -rf $DATA/mainnet*
sudo rm -rf $SNAP/*
echo "Downloading new database..."
curl https://x-vps.com/iota.db.tgz -o iota.db.tgz
echo "Extracting file and setting permissions..."
sudo tar -xf iota.db.tgz -C $SNAP
sudo chown -R root:root $SNAP
sudo chmod -R 755 $SNAP
echo "Removing downloaded file..."
rm iota.db.tgz
echo "Starting IRI container..."
./start.sh
echo "...finished!"
