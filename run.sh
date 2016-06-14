#!/bin/sh

set -euo pipefail
IFS=$'\n\t'

local api_domain=${API_DOMAIN:-api.localhost.localdomain}
local osem_domain=${WEB_DOMAIN:-localhost.localdomain}
local issuer_adr=${ISSUER_ADDRESS:-}

sed -i -e "s|API_DOMAIN|$api_domain|" -e "s|WEB_DOMAIN|$osem_domain|" -e "s|ISSUER_ADDRESS|$issuer_adr|" /etc/caddy/Caddyfile

exec caddy -conf /etc/caddy/Caddyfile
