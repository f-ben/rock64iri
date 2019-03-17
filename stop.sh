#!/bin/sh
echo "Waiting for IRI to stop..."
sudo pkill --signal SIGTERM -f iri.jar && docker stop iri
