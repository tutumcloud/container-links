#!/bin/bash

if [ -z "${SERVER_PORT_22_TCP_ADDR}" ]; then
    echo "Server ADDR must be specified, exiting ...."
    exit 1
fi

if [ -z "${SERVER_PORT_22_TCP_PORT}" ]; then
    echo "Server PORT must be specified, exiting ...."
    exit 1
fi

echo -e "${TUTUM_PUBLIC_KEY}" > /root/.ssh/id_rsa.pub
echo -e "${TUTUM_PRIVATE_KEY}" > /root/.ssh/id_rsa
chmod 400 /root/.ssh/id_rsa

REMOTE_HOST=${SERVER_PORT_22_TCP_ADDR}
REMOTE_PORT=${SERVER_PORT_22_TCP_PORT}
KNOWN_HOSTS="/root/.ssh/known_hosts"
if [ !-f ${KNOWN_HOST} ]; then
    echo "=> Scaning and save fingerprint from the remote server ..."
    ssh-keyscan -p ${REMOTE_PORT} -H ${REMOTE_HOST} > ${KNOWN_HOSTS}
    if [ $(stat -c %s ${KNOWN_HOSTS}) == "0" ]; then
        echo "=> cannot get fingerprint from remote server, exiting ..."
        exit 1
    fi
else
    echo "=> Fingerprint of remote server found, skipping"
fi
echo "====REMOTE FINGERPRINT===="
cat ${KNOWN_HOSTS}
echo "====REMOTE FINGERPRINT===="

ENV_FILE="/server_env.txt"
echo "=> Retrieving server env file"
scp -P ${REMOTE_PORT} ${REMOTE_HOST}:${ENV_FILE} .
if [ "$?" != "0" ]; then
    echo "=> Failed to obtain the environment file from server, exiting ..."
    exit 1
fi

echo "=> Analyzing environment file ... "
TEMP1=$(cat ${ENV_FILE} | grep '[0-9a-zA-Z_]*_PORT=tcp://' | head -n 1)
TEMP2=$(cat ${ENV_FILE} | grep -o '[0-9a-zA-Z_]*_PORT=tcp://' | head -n 1)
TARGET_ADDR_PORT=${TEMP1//${TEMP2}/}
TARGET_ADDR=$(echo "${TARGET_ADDR_PORT}" | awk -F ':' '{print $1}')

PORT_STR=$(cat ${ENV_FILE} | grep '[0-9a-zA-Z_]*_TCP_PORT=')
ARGS=''
PORTS=''
IFS='
'
for LINE in ${PORT_STR}; do
    ARG=" -L 0.0.0.0:PORT:"${TARGET_ADDR}":PORT"
    TEMP3=$(echo "${LINE}" | grep -o '[0-9a-zA-Z_]*_TCP_PORT=')
    PORT=${LINE//${TEMP3}/}
    if echo "${PORTS}" | tr ' ' '\n' | grep "^${PORT}$"; then
        echo "Port ${PORT} is duplicated"
        continue
    else
        echo "Found Port ${PORT}"
        ARG=$(echo "${ARG}" | sed -e 's/PORT/'${PORT}'/g' )
        ARGS+="${ARG}"
        PORTS+="${PORT} "
    fi
done

echo "=> Container "$(hostname -I)"is forwarding port ${PORTS}to target container ${TARGET_ADDR} via ${REMOTE_HOST}:${REMOTE_PORT}"
CMD="autossh -M 0 ${ARGS} -p ${REMOTE_PORT} ${REMOTE_HOST} -N"
eval ${CMD}
