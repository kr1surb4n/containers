#!/bin/bash

# first make Letsencrypt certs for each domain
# 1. main domain
# 2. file upload domain
# 3. conference (muc) domain
#
# Letsencrypt creates only single domain certificates
docker-compose exec xmpp_server prosodyctl --root cert import /etc/letsencrypt/archive
mkdir config/certs/

# move the keys and certs, a small trick
cp data/*.{key, crt} config/certs/
# remove then (we won't need them)
# rm -f data/*.{key, crt}

# fix the priviledges
# sudo chown -R ${PROSODY_UID}:${PROSODY_GID} config/certs/
