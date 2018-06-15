#!/usr/bin/env bash

core_configure_database ()
{
    local envFile="${CORE_DATA}/.env"

    . "$envFile"

    local currentHost="$ARK_DB_HOST"
    local currentUsername="$ARK_DB_USERNAME"
    local currentPassword="$ARK_DB_PASSWORD"
    local currentDatabase="$ARK_DB_DATABASE"

    rm "$envFile"
    touch "$envFile"

    read -p "Enter the database host, or press ENTER for the default [localhost]: " inputHost
    read -p "Enter the database username, or press ENTER for the default [ark]: " inputUsername
    read -p "Enter the database password, or press ENTER for the default [password]: " inputPassword
    read -p "Enter the database name, or press ENTER for the default [ark_${CORE_NETWORK}]: " inputDatabase

    if [[ -z "$inputHost" ]]; then
        echo "ARK_DB_HOST=$ARK_DB_HOST" >> "$envFile" 2>&1
    else
        echo "ARK_DB_HOST=$inputHost" >> "$envFile" 2>&1
    fi

    if [[ -z "$inputUsername" ]]; then
        echo "ARK_DB_USERNAME=$ARK_DB_USERNAME" >> "$envFile" 2>&1
    else
        echo "ARK_DB_USERNAME=$inputUsername" >> "$envFile" 2>&1
    fi

    if [[ -z "$inputPassword" ]]; then
        echo "ARK_DB_PASSWORD=$ARK_DB_PASSWORD" >> "$envFile" 2>&1
    else
        echo "ARK_DB_PASSWORD=$inputPassword" >> "$envFile" 2>&1
    fi

    if [[ -z "$inputDatabase" ]]; then
        echo "ARK_DB_DATABASE=$ARK_DB_DATABASE" >> "$envFile" 2>&1
    else
        echo "ARK_DB_DATABASE=$inputDatabase" >> "$envFile" 2>&1
    fi

    . "$envFile"
}
