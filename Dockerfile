FROM caddy:2.2.0-alpine

COPY Caddyfile /etc/caddy/
COPY vhosts /etc/caddy/vhosts

RUN mkdir -p /etc/caddy/roots/internet-test
RUN echo 'Connection successful! / Verbindung erfolgreich!' > /etc/caddy/roots/internet-test/index.txt
