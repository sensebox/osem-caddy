#!/bin/sh

set -euo pipefail
IFS=$'\n\t'

api_domain=${API_DOMAIN:-api.localhost.localdomain}
osem_domain=${WEB_DOMAIN:-localhost.localdomain}
issuer_adr=${ISSUER_ADDRESS:-}
use_staging_ca=${USE_STAGING_CA:-}

if [[ "$use_staging_ca" == "true" ]]; then
  use_staging_ca="-ca \"https://acme-staging.api.letsencrypt.org/directory\""
else
  use_staging_ca=""
fi

sed -i -e "s|API_DOMAIN|$api_domain|" -e "s|\.WEB_DOMAIN:|.$osem_domain:|" -e "s|\.WEB_DOMAIN|.$osem_domain|" -e "s|WEB_DOMAIN|$osem_domain|" -e "s|ISSUER_ADDRESS|$issuer_adr|" /etc/caddy/Caddyfile

execstr="/usr/bin/caddy $use_staging_ca -conf /etc/caddy/Caddyfile -quic"

eval exec "$execstr"
