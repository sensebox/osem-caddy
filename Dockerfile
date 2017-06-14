FROM alpine:3.6

ENV CADDY_FEATURES "http.git"
  #^ "cors,git,hugo,ipfilter,jsonp,search"

RUN apk --no-cache add curl ca-certificates tar git

RUN curl --silent --show-error --fail --location \
      --header "Accept: application/tar+gzip, application/x-gzip, application/octet-stream" -o - \
      "https://caddyserver.com/download/linux/amd64?plugins=${CADDY_FEATURES}" \
    | tar --no-same-owner -C /usr/bin/ -xz caddy \
    && chmod 0755 /usr/bin/caddy \
    && /usr/bin/caddy -version \
    && curl --silent --show-error --fail --location \
      https://github.com/kelseyhightower/confd/releases/download/v0.11.0/confd-0.11.0-linux-amd64 > /usr/bin/confd \
    && chmod 0755 /usr/bin/confd \
    && /usr/bin/confd -version

ENV HOME /etc/caddy

COPY Caddyfile /etc/caddy/
COPY vhosts /etc/caddy/vhosts
COPY run.sh /

# Copy confd files
COPY confd_files /etc/confd/

EXPOSE 80 443 8000

CMD ["./run.sh"]
