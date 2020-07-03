From nginx:alpine

RUN echo "readinesscheck"  > /usr/share/nginx/html/readinesscheck.txt \
 && echo "livenesscheck"  > /usr/share/nginx/html/livenesscheck.txt

COPY troublemaker.sh /troublemaker.sh
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["nginx", "-g", "daemon off;"]
