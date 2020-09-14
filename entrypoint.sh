#!/bin/sh
TIMESTAMP=$(date +%d-%m-%Y_%T)
DOCUMENT_ROOT=/usr/share/nginx/html

echo "readinesscheck" > ${DOCUMENT_ROOT}/readinesscheck.txt
echo "livenesscheck" > ${DOCUMENT_ROOT}/livenesscheck.txt


echo "Container started at: ${TIMESTAMP}"

# Check if START_DELAY is defined/set or not:
if [ "${START_DELAY}" != "" ]; then
  echo "${TIMESTAMP} - START_DELAY is set - Simulating a slow-start container by sleeping for ${START_DELAY} seconds ..."
  sleep ${START_DELAY}
else
  echo "${TIMESTAMP} - START_DELAY was not set, or was set to zero - not sleeping ..."
fi

# Create index.html with a (new) time-stamp-ed message/heading:
TIMESTAMP=$(date +%d-%m-%Y_%T)
MESSAGE="Web service started at: ${TIMESTAMP}"
echo "${MESSAGE}"
echo "<h1>Kubernetes probes demo - ${MESSAGE}</h1>" > ${DOCUMENT_ROOT}/index.html

# Run whatever was passed in CMD:
echo "Exec-uting: $@"
exec "$@"
