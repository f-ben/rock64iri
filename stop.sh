#!/bin/sh
echo "Waiting up to 60 seconds for IRI to stop..."
docker stop --time=60 iri
