#!/bin/sh

set -euo pipefail
IFS=$'\n\t'

/usr/bin/confd -onetime -backend env

use_staging_ca=${USE_STAGING_CA:-}

STAGING_CA='"https://acme-v02.api.letsencrypt.org/directory"'

if [[ "$use_staging_ca" == "true" ]]; then
  STAGING_CA='"https://acme-staging-v02.api.letsencrypt.org/directory"'
fi

export STAGING_CA

execstr="/usr/bin/caddy run --config /etc/caddy/Caddyfile"

eval exec "$execstr"
