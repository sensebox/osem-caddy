#
# Builder
#
FROM abiosoft/caddy:builder as builder

ARG version="1.0.1"
ARG plugins="git,ratelimit"

RUN VERSION=${version} PLUGINS=${plugins} /bin/sh /usr/bin/builder.sh

# confd
RUN wget -O /usr/bin/confd \
      https://github.com/kelseyhightower/confd/releases/download/v0.16.0/confd-0.16.0-linux-amd64 \
    && chmod 0755 /usr/bin/confd

#
# Final stage
#
FROM alpine:3.10

ARG version="1.0.1"

ENV HOME /etc/caddy

# Telemetry Stats
ENV ENABLE_TELEMETRY="false"

RUN apk add --no-cache \
  ca-certificates \
  git \
  mailcap \
  openssh-client \
  tzdata

# install caddy
COPY --from=builder /install/caddy /usr/bin/caddy
COPY --from=builder /usr/bin/confd /usr/bin/confd

# validate install
RUN /usr/bin/caddy -version
RUN /usr/bin/caddy -plugins

COPY Caddyfile /etc/caddy/
COPY vhosts /etc/caddy/vhosts
COPY run.sh /

# Copy confd files
COPY confd_files /etc/confd/

EXPOSE 80 443 8000

CMD ["./run.sh"]
