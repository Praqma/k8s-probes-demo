#!/bin/sh
TIMESTAMP=$(date +%d-%m-%Y_%T)
READINESS_FILE=/shared/readiness.txt


function create_readiness_file()
{
  while true; do 
    DURATION=${RANDOM:1:2}
    echo "Sleeping for ${DURATION} seconds before creating the readiness file ..."
    sleep ${DURATION}
    echo "Creating ${READINESS_FILE} ..."
    echo readiness > ${READINESS_FILE}
  done
}

function delete_readiness_file()
{
  while true; do
    DURATION=${RANDOM:1:2}
    echo "Sleeping for ${DURATION} seconds before deleting the readiness file ..."
    sleep ${DURATION}
    echo "Deleting ${READINESS_FILE} ..."
    rm ${READINESS_FILE}
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
  echo "Forking create_readiness_file in background..."
  create_readiness_file &

  echo "Forking delete_readiness_file in background..."
  delete_readiness_file &

else

  MESSAGE="Started TROUBLEMAKER container in NORMAL mode - on port 8888 - at: ${TIMESTAMP}"
  echo ${MESSAGE}
  echo "<h1>${MESSAGE}</h1>" > /usr/share/nginx/html/index.html

fi


# Run whatever was passed in CMD.
echo "Exec-uting: $@"
exec "$@"
