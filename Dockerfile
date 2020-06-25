From nginx:alpine

COPY probecheck.txt     /usr/share/nginx/html/probecheck.txt


COPY troublemaker.sh /troublemaker.sh
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]
