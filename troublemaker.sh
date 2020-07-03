#!/bin/sh
TIMESTAMP=$(date +%d-%m-%Y_%T)
READINESSCHECK_FILE=/shared/readinesscheck.txt
LIVENESSCHECK_FILE=/shared/livenesscheck.txt


function create_readinesscheck_file()
{
  while true; do 
    DURATION=${RANDOM:1:2}
    echo "Sleeping for ${DURATION} seconds before creating the readinesscheck file ..."
    sleep ${DURATION}
    echo "Creating ${READINESSCHECK_FILE} ..."
    echo readinesscheck > ${READINESSCHECK_FILE}
  done
}

function delete_readinesscheck_file()
{
  while true; do
    DURATION=${RANDOM:1:2}
    echo "Sleeping for ${DURATION} seconds before deleting the readinesscheck file ..."
    sleep ${DURATION}
    echo "Deleting ${READINESSCHECK_FILE} ..."
    rm ${READINESSCHECK_FILE}
  done
}

function create_livenesscheck_file()
{
  while true; do 
    DURATION=${RANDOM:1:2}
    echo "Sleeping for ${DURATION} seconds before creating the readinesscheck file ..."
    sleep ${DURATION}
    echo "Creating ${LIVENESSCHECK_FILE} ..."
    echo livenesscheck > ${LIVENESSCHECK_FILE}
  done
}

function delete_livenesscheck_file()
{
  while true; do
    DURATION=${RANDOM:1:2}
    echo "Sleeping for ${DURATION} seconds before deleting the livenesscheck file ..."
    sleep ${DURATION}
    echo "Deleting ${LIVENESSCHECK_FILE} ..."
    rm ${LIVENESSCHECK_FILE}
  done
}

# Change the port of nginx to 8888
sed -i "s/80;/8888;/g" /etc/nginx/conf.d/default.conf

if [ "${ROLE}" == "TROUBLEMAKER" ]; then
  MESSAGE="Started TROUBLEMAKER container in TROUBLEMAKER mode - on port 8888 - at: ${TIMESTAMP}"
  echo ${MESSAGE}
  echo "<h1>${MESSAGE}</h1>" > /usr/share/nginx/html/index.html
  
  # Fork the following processes, 
  #  so they keep doing their thing in the background, with random delay.
  
  echo "Forking create_readinesscheck_file in background..."
  create_readinesscheck_file &

  echo "Forking delete_readinesscheck_file in background..."
  delete_readinesscheck_file &

  echo "Forking create_livenesscheck_file in background..."
  create_livenesscheck_file &

  echo "Forking delete_livenesscheck_file in background..."
  delete_livenesscheck_file &


else

  MESSAGE="Started TROUBLEMAKER container in NORMAL mode - on port 8888 - at: ${TIMESTAMP}"
  echo ${MESSAGE}
  echo "<h1>${MESSAGE}</h1>" > /usr/share/nginx/html/index.html

fi


# Run whatever was passed in CMD.
echo "Exec-uting: $@"
exec "$@"
