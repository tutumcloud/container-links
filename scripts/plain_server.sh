#!/bin/bash

echo "=> Hosname:" $(hostname -I)
echo "=> Analyzing enviornment variables ..."
TEMP1=$(env| grep [0-9a-zA-Z_]*_PORT=tcp://)
TEMP2=$(env| grep -o [0-9a-zA-Z_]*_PORT=tcp://)
TEMP3=${TEMP1//${TEMP2}/}
TARGET_ADDR=$(echo ${TEMP3} | cut -d \: -f 1)
TARGET_PORT=$(echo ${TEMP3} | cut -d \: -f 2)

if [ -n "${TARGET_ADDR}" ]; then
    echo "=> Found address to forward: ${TARGET_ADDR}"
else
    echo "=> Cannot find address to forward, exiting ..."
fi

if [ -n "${TARGET_PORT}" ]; then
    echo "=> Found port to forward: ${TARGET_PORT}"
else
    echo "=> Cannot find address to forward, exiting ..."
fi

echo "=> Forwarding all the tcp traffic on port 22 to ${TARGET_ADDR}:${TARGET_PORT}"
exec /usr/bin/socat TCP-LISTEN:22,fork TCP:${TARGET_ADDR}:${TARGET_PORT}
