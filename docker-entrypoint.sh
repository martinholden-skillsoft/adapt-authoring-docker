#!/bin/bash

file_env() {
    local var="$1"
    local fileVar="${var}_FILE"
    local def="${2:-}"

    if [ "${!var:-}" ] && [ "${!fileVar:-}" ]; then
        echo >&2 "error: both $var and $fileVar are set (but are exclusive)"
        exit 1
    fi
    local val="$def"
    if [ "${!var:-}" ]; then
        val="${!var}"
    elif [ "${!fileVar:-}" ]; then
        val="$(< "${!fileVar}")"
    fi
    export "$var"="$val"
    unset "$fileVar"
}

load_vars() {
    file_env "ADMIN_PASSWORD"
    file_env "SESSION_KEY"
}

install_adapt() {
    echo "No 'conf' dir found, running 'node install...'"

    tenantname=`od -x /dev/urandom | head -1 | awk '{OFS=""; print $2$3,$4,$5,$6,$7$8$9}'`

    # See https://github.com/adaptlearning/adapt_authoring/issues/2566
    npm config set unsafe-perm true

    yes "" | node install --install Y \
        --authoringToolRepository https://github.com/adaptlearning/adapt_authoring.git \
        --frameworkRepository https://github.com/adaptlearning/adapt_framework.git \
        --serverPort "5000" \
        --serverName "adapt" \
        --dbHost "db" \
        --dbName "adapt-authoring-tool" \
        --dbPort "27017" \
        --useConnectionUri false \
        --dataRoot "data" \
        --sessionSecret "${SESSION_KEY}" \
        --useffmpeg "Y" \
        --masterTenantName "$tenantname" \
        --masterTenantDisplayName "$tenantname" \
        --suEmail "${ADMIN_EMAIL}" \
        --suPassword "${ADMIN_PASSWORD}" \
        --suRetypePassword "${ADMIN_PASSWORD}" \
        --useSmtp true \
        --smtpService "none" \
        --smtpConnectionUrl "smtp://postfix_relay_app" \
        --fromAddress "adapt@localhost.com" \
        --smtpUsername "adapt@localhost.com" \
        --smtpPassword "Password@123"
}

main() {
    set -eu

    load_vars

    if [ ! -d conf ]; then
        install_adapt
    fi
}

main

exec "$@"
