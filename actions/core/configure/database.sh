#!/usr/bin/env bash

core_configure_database ()
{
    local envFile="${CORE_DATA}/.env"

    . "$envFile"

    read -p "Enter the database host, or press ENTER for the default [$ARK_DB_HOST]: " inputHost
    read -p "Enter the database port, or press ENTER for the default [$ARK_DB_PORT]: " inputPort
    read -p "Enter the database username, or press ENTER for the default [$ARK_DB_USERNAME]: " inputUsername
    read -p "Enter the database password, or press ENTER for the default [$ARK_DB_PASSWORD]: " inputPassword
    read -p "Enter the database name, or press ENTER for the default [ark_${CORE_NETWORK}]: " inputDatabase

    if [[ ! -z "$inputHost" ]]; then
        sed -i -e "s/ARK_DB_HOST=$ARK_DB_HOST/ARK_DB_HOST=$inputHost/g" "$envFile"
    fi

    if [[ ! -z "$inputPort" ]]; then
        sed -i -e "s/ARK_DB_PORT=$ARK_DB_PORT/ARK_DB_PORT=$inputPort/g" "$envFile"
    fi

    if [[ ! -z "$inputUsername" ]]; then
        sed -i -e "s/ARK_DB_USERNAME=$ARK_DB_USERNAME/ARK_DB_USERNAME=$inputUsername/g" "$envFile"
    fi

    if [[ ! -z "$inputPassword" ]]; then
        sed -i -e "s/ARK_DB_PASSWORD=$ARK_DB_PASSWORD/ARK_DB_PASSWORD=$inputPassword/g" "$envFile"
    fi

    if [[ ! -z "$inputDatabase" ]]; then
        sed -i -e "s/ARK_DB_DATABASE=$ARK_DB_DATABASE/ARK_DB_DATABASE=$inputDatabase/g" "$envFile"
    fi

    . "$envFile"
}
