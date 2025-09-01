#!/bin/bash

MOUNTED_VOLUME_PATH="/home/cs181ca-user"

# Copy gem5 directories if they don't exist in the mounted volume
if [ ! -d "$MOUNTED_VOLUME_PATH/gem5" ]; then
    sudo mv /home/gem5 "$MOUNTED_VOLUME_PATH" > /dev/null 2>&1
fi

exec "$@"
