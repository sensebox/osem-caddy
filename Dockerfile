#
# Builder
#
FROM abiosoft/caddy:builder as builder

ARG version="0.10.11"
ARG plugins="git"

RUN VERSION=${version} PLUGINS=${plugins} /bin/sh /usr/bin/builder.sh

# confd
RUN wget -O /usr/bin/confd \
      https://github.com/kelseyhightower/confd/releases/download/v0.11.0/confd-0.11.0-linux-amd64 \
    && chmod 0755 /usr/bin/confd

#
# Final stage
#
FROM alpine:3.7

ENV HOME /etc/caddy

RUN apk add --no-cache ca-certificates git

# install caddy
COPY --from=builder /install/caddy /usr/bin/caddy
COPY --from=builder /usr/bin/confd /usr/bin/confd

COPY Caddyfile /etc/caddy/
COPY vhosts /etc/caddy/vhosts
COPY run.sh /

# Copy confd files
COPY confd_files /etc/confd/

EXPOSE 80 443 8000

CMD ["./run.sh"]
