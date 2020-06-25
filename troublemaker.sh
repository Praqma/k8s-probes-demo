#!/bin/sh
TIMESTAMP=$(date +%d-%m-%Y_%T)
PROBECHECK_FILE=/shared/probecheck.txt


function create_probecheck_file()
{
  while true; do 
    DURATION=${RANDOM:1:2}
    echo "Sleeping for ${DURATION} seconds before creating the probecheck file ..."
    sleep ${DURATION}
    echo "Creating ${PROBECHECK_FILE} ..."
    echo probecheck > ${PROBECHECK_FILE}
  done
}

function delete_probecheck_file()
{
  while true; do
    DURATION=${RANDOM:1:2}
    echo "Sleeping for ${DURATION} seconds before deleting the probecheck file ..."
    sleep ${DURATION}
    echo "Deleting ${PROBECHECK_FILE} ..."
    rm ${PROBECHECK_FILE}
  done
}

# Change the port of nginx to 8888
sed -i "s/80;/8888;/g" /etc/nginx/conf.d/default.conf

if [ "${ROLE}" == "TROUBLEMAKER" ]; then
  MESSAGE="Started TROUBLEMAKER container in TROUBLEMAKER mode - on port 8888 - at: ${TIMESTAMP}"
  echo ${MESSAGE}
  echo "<h1>${MESSAGE}</h1>" > /usr/share/nginx/html/index.html
  
  # Fork the following two processes, 
  #  so they keep doing their thing in the background, with random delay.
  echo "Forking create_probecheck_file in background..."
  create_probecheck_file &

  echo "Forking delete_probecheck_file in background..."
  delete_probecheck_file &

else

  MESSAGE="Started TROUBLEMAKER container in NORMAL mode - on port 8888 - at: ${TIMESTAMP}"
  echo ${MESSAGE}
  echo "<h1>${MESSAGE}</h1>" > /usr/share/nginx/html/index.html

fi


# Run whatever was passed in CMD.
echo "Exec-uting: $@"
exec "$@"
