#!/bin/bash

if [ -z "${TUTUM_PUBLIC_KEY}" ]; then
    if [ -z "${SERVER_PORT_22_TCP_ADDR}" ] && [ -z "${SERVER_PORT_22_TCP_PORT}" ]; then
        echo "=> link container is running in PLAINTEXT SERVER mode ..."
        /plain_server.sh
    elif [ -n "${SERVER_PORT_22_TCP_ADDR}" ] && [ -n "${SERVER_PORT_22_TCP_PORT}" ]; then
        echo "=> link container is running in PLAINTEXT CLIENT mode ..."
        /plain_client.sh
    else
        if [ -z "${SERVER_PORT_22_TCP_ADDR}" ]; then
            echo "Server ADDR must be specified, exiting ...."
            exit 1
        fi
        if [ -z "${SERVER_PORT_22_TCP_PORT}" ]; then
            echo "Server PORT must be specified, exiting ...."
            exit 1
        fi
    fi
else
    if [ -z "${TUTUM_PRIVATE_KEY}" ]; then
        echo "=> link container is running in ENCRYPTED SERVER mode ..."
        /encrypted_server.sh
    else
        echo "=> link container is running in ENCRYPTED CLIENT mode ..."
        /encrypted_client.sh
    fi
fi
