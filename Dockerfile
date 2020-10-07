#
# Builder
#
FROM caddy:2.2.0-alpine as builder

# confd
RUN wget -O /usr/bin/confd \
      https://github.com/kelseyhightower/confd/releases/download/v0.16.0/confd-0.16.0-linux-amd64 \
    && chmod 0755 /usr/bin/confd

#
# Final stage
#
FROM alpine:3.12.0

RUN apk add --no-cache ca-certificates git

# install caddy
COPY --from=builder /usr/bin/caddy /usr/bin/caddy
COPY --from=builder /usr/bin/confd /usr/bin/confd

COPY Caddyfile /etc/caddy/
COPY vhosts /etc/caddy/vhosts
COPY run.sh /

RUN mkdir -p /etc/caddy/roots/internet-test
RUN echo 'Connection successful! / Verbindung erfolgreich!' > /etc/caddy/roots/internet-test/index.txt

# Copy confd files
COPY confd_files /etc/confd/

EXPOSE 80 443 8000

CMD ["./run.sh"]