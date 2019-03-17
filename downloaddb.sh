#!/bin/sh

echo "Stopping IRI container..."
./stop.sh
echo "Deleting old database..."
rm -rf ./data/mainnet*
rm -rf ./data/spent-addresses-db
echo "Downloading new database..."
curl https://x-vps.com/iota.db.tgz -o iota.db.tgz
echo "Extracting file..."
tar -xf iota.db.tgz -C ./data
echo "Removing downloaded file..."
rm iota.db.tgz
echo "Starting IRI container..."
./start.sh
echo "...finished!"
