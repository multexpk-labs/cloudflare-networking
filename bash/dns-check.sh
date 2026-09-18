#!/usr/bin/env bash
set -u

DOMAIN="${1:-}"

if [[ -z "$DOMAIN" ]]; then
  echo "Usage: $0 <domain>"
  exit 2
fi

echo "=== DNS CHECK ==="
echo "Domain: $DOMAIN"
echo

echo "--- A ---"
dig +short A "$DOMAIN"

echo "--- AAAA ---"
dig +short AAAA "$DOMAIN"

echo "--- CNAME ---"
dig +short CNAME "$DOMAIN"

echo "--- MX ---"
dig +short MX "$DOMAIN"

echo "--- Nameservers ---"
dig +short NS "$DOMAIN"
