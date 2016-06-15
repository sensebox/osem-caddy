FROM alpine:3.4

RUN apk add --update-cache curl ca-certificates \
  && rm -rf /var/cache/apk/*

# ENV CADDY_VERSION 0.8.3
ENV CADDY_FEATURES "cors"
  #^ "cors,git,hugo,ipfilter,jsonp,search"

ENV HOME /etc/caddy

RUN curl -fsSL "http://caddyserver.com/download/build?os=linux&arch=amd64&features=$CADDY_FEATURES" \
    | tar -xz -C /usr/bin \
  && chmod u+x /usr/bin/caddy

COPY ./Caddyfile /etc/caddy/
COPY ./run.sh /

EXPOSE 80 443 8000

CMD ["./run.sh"]
