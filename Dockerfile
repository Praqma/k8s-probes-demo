From nginx:alpine

COPY readiness.txt     /usr/share/nginx/html/readiness.txt
COPY liveness.txt      /usr/share/nginx/html/liveness.txt


COPY troublemaker.sh /troublemaker.sh
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]
