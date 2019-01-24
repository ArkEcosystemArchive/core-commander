#!/usr/bin/env bash

core_configure_database ()
{
    ascii

    local envFile="${CORE_PATH_CONFIG}/.env"

    . "$envFile"

    read -p "Enter the database host, or press ENTER for the default [$CORE_DB_HOST]: " inputHost
    read -p "Enter the database port, or press ENTER for the default [$CORE_DB_PORT]: " inputPort
    read -p "Enter the database username, or press ENTER for the default [$CORE_DB_USERNAME]: " inputUsername
    read -p "Enter the database password, or press ENTER for the default [$CORE_DB_PASSWORD]: " inputPassword
    read -p "Enter the database name, or press ENTER for the default [ark_${CORE_NETWORK}]: " inputDatabase

    if [[ ! -z "$inputHost" ]]; then
        sed -i -e "s/CORE_DB_HOST=$CORE_DB_HOST/CORE_DB_HOST=$inputHost/g" "$envFile"
    fi

    if [[ ! -z "$inputPort" ]]; then
        sed -i -e "s/CORE_DB_PORT=$CORE_DB_PORT/CORE_DB_PORT=$inputPort/g" "$envFile"
    fi

    if [[ ! -z "$inputUsername" ]]; then
        sed -i -e "s/CORE_DB_USERNAME=$CORE_DB_USERNAME/CORE_DB_USERNAME=$inputUsername/g" "$envFile"
    fi

    if [[ ! -z "$inputPassword" ]]; then
        sed -i -e "s/CORE_DB_PASSWORD=$CORE_DB_PASSWORD/CORE_DB_PASSWORD=$inputPassword/g" "$envFile"
    fi

    if [[ ! -z "$inputDatabase" ]]; then
        sed -i -e "s/CORE_DB_DATABASE=$CORE_DB_DATABASE/CORE_DB_DATABASE=$inputDatabase/g" "$envFile"
    else
        sed -i -e "s/CORE_DB_DATABASE=$CORE_DB_DATABASE/CORE_DB_DATABASE=ark_${CORE_NETWORK}/g" "$envFile"
    fi

    . "$envFile"
}
