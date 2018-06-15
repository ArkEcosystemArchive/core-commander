#!/usr/bin/env bash

core_configure ()
{
    ascii

    local configured=false

    if [[ -d "$CORE_CONFIG" ]]; then
        read -p "We found an ARK Core configuration, do you want to overwrite it? [y/N] : " choice

        if [[ "$choice" =~ ^(yes|y|Y) ]]; then
            __core_configure_pre

            rm -rf "$CORE_CONFIG"

            __core_configure_network

            __core_configure_database

            __core_configure_post

            configured=true
        else
            warning "Skipping configuration..."
        fi
    else
        __core_configure_pre

        __core_configure_network

        __core_configure_database

        __core_configure_post

        configured=true
    fi

    if [[ "$configured" = true ]]; then
        read -p "ARK Core has been configured, would you like to start the relay? [Y/n] : " choice

        if [[ -z "$choice" || "$choice" =~ ^(yes|y|Y) ]]; then
            relay_start
        fi
    fi
}

__core_configure_pre ()
{
    if [[ "$STATUS_RELAY" = "On" ]]; then
        relay_stop
    fi

    if [[ "$STATUS_FORGER" = "On" ]]; then
        forger_stop
    fi
}

__core_configure_post ()
{
    database_create
}

__core_configure_network ()
{
    info "Which network would you like to configure?"

    validNetworks=("mainnet" "devnet" "testnet")

    select opt in "${validNetworks[@]}"; do
        case "$opt" in
            "mainnet")
                __core_configure_core "mainnet"
                __core_configure_commander "mainnet"
                break
            ;;
            "devnet")
                __core_configure_core "devnet"
                __core_configure_commander "devnet"
                break
            ;;
            "testnet")
                __core_configure_core "testnet"
                __core_configure_commander "testnet"
                break
            ;;
            *)
                echo "Invalid option $REPLY"
            ;;
        esac
    done

    . "$commander_config"
}

__core_configure_database ()
{
    local envFile="${CORE_DATA}/.env"

    . "$envFile"

    local currentHost="$ARK_DB_HOST"
    local currentUsername="$ARK_DB_USERNAME"
    local currentPassword="$ARK_DB_PASSWORD"
    local currentDatabase="$ARK_DB_DATABASE"

    rm "$envFile"
    touch "$envFile"

    read -p "Please enter your database host [localhost]: " inputHost
    read -p "Please enter your database host [ark]: " inputUsername
    read -p "Please enter your database host [password]: " inputPassword
    read -p "Please enter your database host [ark_${CORE_NETWORK}]: " inputDatabase

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

__core_configure_core ()
{
    if [[ ! -d "$CORE_DATA" ]]; then
        mkdir "$CORE_DATA"
    fi

    cp -r "${CORE_DIR}/packages/core/lib/config/$1" "$CORE_CONFIG"
}

__core_configure_commander ()
{
    rm "$commander_config"
    touch "$commander_config"

    echo "CORE_REPO=$CORE_REPO" >> "$commander_config" 2>&1
    echo "CORE_DIR=$CORE_DIR" >> "$commander_config" 2>&1
    echo "CORE_DATA=$CORE_DATA" >> "$commander_config" 2>&1
    echo "CORE_CONFIG=$CORE_CONFIG" >> "$commander_config" 2>&1
    echo "CORE_TOKEN=$CORE_TOKEN" >> "$commander_config" 2>&1
    echo "CORE_NETWORK=$1" >> "$commander_config" 2>&1
    echo "EXPLORER_REPO=$EXPLORER_REPO" >> "$commander_config" 2>&1
    echo "EXPLORER_DIR=$EXPLORER_DIR" >> "$commander_config" 2>&1
}
