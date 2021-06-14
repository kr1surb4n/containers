#!/bin/bash
#docker-compose exec xmpp_server prosodyctl deluser $
USERNAME=$2
PASSWORD=$3
docker-compose exec xmpp_server prosodyctl register $USER_NAME $DOMAIN $USER_PASSWORD
