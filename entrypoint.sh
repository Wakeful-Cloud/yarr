#!/bin/sh

# Get options
UID="${UID:-1000}"
GID="${GID:-1000}"
ADDRESS="${ADDRESS:-0.0.0.0}"
PORT="${PORT:-7070}"
DATA="${DATA:-/data}"
ACKNOWLEDGE_DEPRECATION="${ACKNOWLEDGE_DEPRECATION:-false}"

# Show deprecation warning
echo -e "██╗    ██╗ █████╗ ██████╗ ███╗   ██╗██╗███╗   ██╗ ██████╗ \n██║    ██║██╔══██╗██╔══██╗████╗  ██║██║████╗  ██║██╔════╝ \n██║ █╗ ██║███████║██████╔╝██╔██╗ ██║██║██╔██╗ ██║██║  ███╗\n██║███╗██║██╔══██║██╔══██╗██║╚██╗██║██║██║╚██╗██║██║   ██║\n╚███╔███╔╝██║  ██║██║  ██║██║ ╚████║██║██║ ╚████║╚██████╔╝\n ╚══╝╚══╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝╚═╝  ╚═══╝ ╚═════╝ \nThis container image is deprecated. See the below for more information:\nhttps://github.com/nkanaev/yarr/issues/20#issuecomment-5492234468\nhttps://nkanaev.github.io/yarr/en/installation/docker/\n"
if [ "$ACKNOWLEDGE_DEPRECATION" != "true" ]; then
    echo -e "Please set the ACKNOWLEDGE_DEPRECATION environment variable to true to\nacknowledge this warning and continue anyway.\n"
    exit 1
fi

# Create the user
addgroup -S -g $GID yarr
adduser -S -u $UID -h /home/yarr -H -G yarr yarr

# Take ownership
chown yarr:yarr /home/yarr
chown yarr:yarr $DATA

# Start the server as the yarr user
echo "Starting yarr as $UID:$GID..."
exec su-exec yarr:yarr /home/yarr/yarr -addr "$ADDRESS:$PORT" -db "$DATA/yarr.db"