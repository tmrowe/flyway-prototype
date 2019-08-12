#!/bin/bash
set -e

# Install the pgcrypto extension so the database can generate UUIDs.
psql -v ON_ERROR_STOP=1 --dbname "flyway" --username "postgres" <<-EOSQL
create extension pgcrypto;
EOSQL
