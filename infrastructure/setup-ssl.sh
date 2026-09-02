#!/bin/sh

set -eu

DOMAIN="${APP_DOMAIN:-transcendence.test}"
SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
CERT_DIR="$SCRIPT_DIR/nginx/certs"

if ! command -v mkcert >/dev/null 2>&1; then
    echo "mkcert not found."
    exit 1
fi

mkdir -p "$CERT_DIR"

mkcert -install
mkcert \
    -cert-file "$CERT_DIR/$DOMAIN.pem" \
    -key-file "$CERT_DIR/$DOMAIN-key.pem" \
    "$DOMAIN" localhost 127.0.0.1 ::1

echo "SSL certificates are ready!"
