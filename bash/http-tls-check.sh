#!/usr/bin/env bash
set -u

DOMAIN="${1:-}"

if [[ -z "$DOMAIN" ]]; then
  echo "Usage: $0 <domain>"
  exit 2
fi

echo "=== HTTP ==="
curl -I --max-time 15 "https://$DOMAIN" || true

echo
echo "=== TLS ==="
openssl s_client \
  -connect "$DOMAIN:443" \
  -servername "$DOMAIN" \
  </dev/null 2>/dev/null |
  openssl x509 -noout -subject -issuer -dates 2>/dev/null || true
