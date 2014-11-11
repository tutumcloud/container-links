#!/bin/bash

REMOTE_ADDR=${SERVER_PORT_22_TCP_ADDR}
REMOTE_PORT=${SERVER_PORT_22_TCP_PORT}
LISTENING_PORT=${LINKS_LISTENING_PORT}

if [ -z "${LISTENING_PORT}" ]; then
    echo "Cannot find LINKS_LISTENING_PORT, exiting"
    exit 1
fi

echo "=> Forwarding all the tcp traffic on port ${LISTENING_PORT} to ${REMOTE_ADDR}:${REMOTE_PORT}"
exec /usr/bin/socat TCP-LISTEN:${LISTENING_PORT},fork TCP:${REMOTE_ADDR}:${REMOTE_PORT}
