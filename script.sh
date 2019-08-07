#!/bin/bash

set -e

# This script will create a new snapshot from a volume and only keep the 5 latest snapshots
# Customize the following env variables
# * VOLUME_ID
# * SNAPSHOT_NAME
# * DIGITALOCEAN_TOKEN

DATE=`date '+%Y%m%d-%H%M%S'`

if [ -z $VOLUME_ID ] || [ -z $SNAPSHOT_NAME ]; then
    >&2 echo "Pease set \$AWS_ACCESS_KEY_ID and \$AWS_SECRET_ACCESS_KEY"
    exit 1
fi

curl -X POST \
  "https://api.digitalocean.com/v2/volumes/$VOLUME_ID/snapshots" \
  -H "authorization: Bearer $DIGITALOCEAN_TOKEN" \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -d "{
  \"name\": \"$SNAPSHOT_NAME-$DATE\"
}"


OLD_SNAPSHOTS=$(curl https://api.digitalocean.com/v2/snapshots?resource_type=volume \
-H "authorization: Bearer $DIGITALOCEAN_TOKEN" -H 'cache-control: no-cache' \
-H 'content-type: application/json' | jq ".snapshots|sort_by(.created_at)[:-5][] | .id" | sed "s/\"//g")

for SNAPSHOT_ID in $OLD_SNAPSHOTS
do
    curl -X DELETE -H 'Content-Type: application/json' \
    -H "authorization: Bearer $DIGITALOCEAN_TOKEN" "https://api.digitalocean.com/v2/snapshots/$SNAPSHOT_ID"
done
