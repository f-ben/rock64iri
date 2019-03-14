#!/bin/sh

echo "Deleting old database..."
rm -rf ./data/iri/mainnet*
rm -rf ./data/iri/spent-addresses-db
echo "Downloading new database..."
curl https://x-vps.com/iota.db.tgz -o iota.db.tgz
echo "Extracting file..."
tar -xf iota.db.tgz -C ./data/iri
echo "Removing downloaded file..."
rm iota.db.tgz
echo "...finished!"
