#!/usr/bin/env bash

core_configure_log_level ()
{
    local envFile="${CORE_DATA}/.env"

    . "$envFile"

    read -p "Enter the log level (debug, info, warning), or press ENTER for the default [$ARK_LOG_LEVEL]: " inputLevel

    if [[ ! -z "$inputLevel" ]]; then
        sed -i -e "s/ARK_LOG_LEVEL=$ARK_LOG_LEVEL/ARK_LOG_LEVEL=$inputLevel/g" "$envFile"
    fi

    . "$envFile"
}
