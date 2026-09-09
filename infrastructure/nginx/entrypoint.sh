#!/bin/sh

set -eu

export APP_DOMAIN APP_ORIGIN

CERT_DIR=/etc/nginx/certs
CERT_FILE="$CERT_DIR/$APP_DOMAIN.pem"
KEY_FILE="$CERT_DIR/$APP_DOMAIN-key.pem"

if [ ! -s "$CERT_FILE" ] || [ ! -s "$KEY_FILE" ]; then
    mkdir -p "$CERT_DIR"
    openssl req -x509 -nodes -newkey rsa:2048 -sha256 -days 3650 \
        -keyout "$KEY_FILE" \
        -out "$CERT_FILE" \
        -subj "/CN=$APP_DOMAIN" \
        -addext "subjectAltName=DNS:$APP_DOMAIN,DNS:localhost,IP:127.0.0.1"
fi

envsubst '${APP_DOMAIN} ${APP_ORIGIN}' \
    < /etc/nginx/templates/default.conf.template \
    > /etc/nginx/conf.d/default.conf

exec nginx -g "daemon off;"
