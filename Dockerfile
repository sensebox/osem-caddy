FROM alpine:3.5

ENV CADDY_FEATURES "git"
  #^ "cors,git,hugo,ipfilter,jsonp,search"

RUN apk --no-cache add curl ca-certificates tar git

RUN curl --silent --show-error --fail --location \
      --header "Accept: application/tar+gzip, application/x-gzip, application/octet-stream" -o - \
      "https://caddyserver.com/download/build?os=linux&arch=amd64&features=$CADDY_FEATURES" \
    | tar --no-same-owner -C /usr/bin/ -xz caddy \
 && chmod 0755 /usr/bin/caddy \
 && /usr/bin/caddy -version

ENV HOME /etc/caddy

COPY Caddyfile /etc/caddy/
COPY run.sh /

EXPOSE 80 443 8000

CMD ["./run.sh"]
