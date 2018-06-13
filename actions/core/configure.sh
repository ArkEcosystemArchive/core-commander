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

            __core_configure_post

            configured=true
        else
            warning "Skipping configuration..."
        fi
    else
        __core_configure_pre

        __core_configure_network

        __core_configure_post

        configured=true
    fi

    if [[ "$configured" = true ]]; then
        read -p "ARK Core has been configured, would you like to start the relay? [Y/n] : " choice

        if [[ "$choice" =~ ^(yes|y|Y) ]]; then
            relay_start
        fi
    fi
}

__core_configure_pre ()
{
    relay_stop
    forger_stop
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

    echo "CORE_REPO=$CORE_REPO" >> "$commander_config"
    echo "CORE_DIR=$CORE_DIR" >> "$commander_config"
    echo "CORE_DATA=$CORE_DATA" >> "$commander_config"
    echo "CORE_CONFIG=$CORE_CONFIG" >> "$commander_config"
    echo "CORE_TOKEN=$CORE_TOKEN" >> "$commander_config"
    echo "CORE_NETWORK=$1" >> "$commander_config"
    echo "EXPLORER_REPO=$EXPLORER_REPO" >> "$commander_config"
    echo "EXPLORER_DIR=$EXPLORER_DIR" >> "$commander_config"
}
