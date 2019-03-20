#!/bin/sh
DATA=./data
DB=$DATA/mainnetdb
DBLOG=$DATA/mainnetdb.log
SNAP=$DATA/snapshots
SPENT=$DATA/spent-addresses-db
SPENTLOG=$DATA/spent-addresses-db.log
echo "Stopping IRI container..."
./stop.sh
echo "Deleting old database..."
sudo rm -rf $DB
sudo rm -rf $DBLOG
sudo rm -rf $SNAP
sudo rm -rf $SPENT
sudo rm -rf $SPENTLOG
echo "Downloading new database..."
curl https://x-vps.com/iota.db.tgz -o iota.db.tgz
echo "Extracting file and setting permissions..."
sudo mkdir -p $DB
sudo mkdir -p $DBLOG
sudo mkdir -p $SNAP
sudo mkdir -p $SPENT
sudo mkdir -p $SPENTLOG
sudo tar -xf iota.db.tgz -C $SNAP
sudo mv $SNAP/spent-addresses-db/* $SPENT/
sudo rm -rf $SNAP/spent-addresses-db
sudo chown -R root:root $DB
sudo chown -R root:root $DBLOG
sudo chown -R root:root $SNAP
sudo chown -R root:root $SPENT
sudo chown -R root:root $SPENTLOG
echo "Removing downloaded file..."
rm iota.db.tgz
echo "Starting IRI container..."
./start.sh
echo "...finished!"
