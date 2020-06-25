#!/bin/sh
echo "Container started at: $(date +%d-%m-%Y_%T)"

# Check if START_DELAY is defined/set or not:
if [ "${START_DELAY}" != "" ]; then
  echo "START_DELAY is set - sleeping for ${START_DELAY} seconds ..."
  sleep ${START_DELAY}
else
  echo "START_DELAY was not set, or was set to zero - not sleeping ..."
fi

# Create index.html with a time-stamp-ed message/heading:

MESSAGE="Web service started at: $(date +%d-%m-%Y_%T)"
echo "${MESSAGE}"
echo "<h1>Kubernetes probes demo - ${MESSAGE}</h1>" > /usr/share/nginx/html/index.html

# Run whatever was passed in CMD:
echo "Exec-uting: $@"
exec "$@"
