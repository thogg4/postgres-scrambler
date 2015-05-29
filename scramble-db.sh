#!/bin/bash
set -e

if [ -z "$POSTGRES_DB" ]; then echo "Need to set POSTGRES_DB"; exit 1; fi
if [ -z "$POSTGRES_USER" ]; then echo "Need to set POSTGRES_USER"; exit 1; fi
if [ -z "$POSTGRES_PASSWORD" ]; then echo "Need to set POSTGRES_PASSWORD"; exit 1; fi
if [ -z "$POSTGRES_HOST" ]; then echo "Need to set POSTGRES_HOST"; exit 1; fi

nohup /docker-entrypoint.sh postgres &
echo "Sleeping while postgres starts up..."
sleep 15

export PGPASSWORD=$POSTGRES_PASSWORD

echo "Dumping remote posgres"
pg_dump -U $POSTGRES_USER -h $POSTGRES_HOST -d $POSTGRES_DB -f dump.sql

echo "Loading db dump into local postgres"
psql -U $POSTGRES_USER -h localhost -d $POSTGRES_DB -f /script/dump.sql

echo "Running your script on local postgres"
psql -U $POSTGRES_USER -h localhost -d $POSTGRES_DB -f /script/scramble-db.sql

echo "Dumping local postgres into /scrambler-output directory"
pg_dump -U $POSTGRES_USER -h localhost -d $POSTGRES_DB -f /scrambler-output/dump.sql
