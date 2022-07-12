#!/bin/sh

# Get options
UID="${UID:-1000}"
GID="${GID:-1000}"
ADDRESS="${ADDRESS:-0.0.0.0}"
PORT="${PORT:-7070}"
DATA="${DATA:-/data}"

# Create the user
addgroup -S -g $GID yarr
adduser -S -u $UID -h /home/yarr -H -G yarr yarr

# Take ownership
chown yarr:yarr /home/yarr
chown yarr:yarr $DATA

# Start the server as the yarr user
echo "Starting yarr as $UID:$GID..."
su-exec yarr:yarr /home/yarr/yarr -addr "$ADDRESS:$PORT" -db "$DATA/yarr.db"