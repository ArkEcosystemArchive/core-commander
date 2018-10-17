#!/usr/bin/env bash

core_configure_hosts_and_ports ()
{
    local envFile="${CORE_DATA}/.env"

    . "$envFile"

    # @arkecosystem/core-p2p
    read -p "Would you like to configure the P2P API? [y/N] : " choice

    if [[ "$choice" =~ ^(yes|y|Y) ]]; then
        read -p "Enter the P2P API host, or press ENTER for the default [${ARK_P2P_HOST}]: " inputHost
        read -p "Enter the P2P API port, or press ENTER for the default [${ARK_P2P_PORT}]: " inputPort

        if [[ ! -z "$inputHost" ]]; then
            sed -i -e "s/ARK_P2P_HOST=$ARK_P2P_HOST/ARK_P2P_HOST=$inputHost/g" "$envFile"
        fi

        if [[ ! -z "$inputPort" ]]; then
            sed -i -e "s/ARK_P2P_PORT=$ARK_P2P_PORT/ARK_P2P_PORT=$inputPort/g" "$envFile"
        fi
    fi

    # @arkecosystem/core-api
    read -p "Would you like to configure the Public API? [y/N] : " choice

    if [[ "$choice" =~ ^(yes|y|Y) ]]; then
        read -p "Enter the Public API host, or press ENTER for the default [${ARK_API_HOST}]: " inputHost
        read -p "Enter the Public API port, or press ENTER for the default [${ARK_API_PORT}]: " inputPort

        if [[ ! -z "$inputHost" ]]; then
            sed -i -e "s/ARK_API_HOST=$ARK_API_HOST/ARK_API_HOST=$inputHost/g" "$envFile"
        fi

        if [[ ! -z "$inputPort" ]]; then
            sed -i -e "s/ARK_API_PORT=$ARK_API_PORT/ARK_API_PORT=$inputPort/g" "$envFile"
        fi
    fi

    # @arkecosystem/core-webhooks
    read -p "Would you like to configure the Webhooks API? [y/N] : " choice

    if [[ "$choice" =~ ^(yes|y|Y) ]]; then
        read -p "Enter the Webhooks API host, or press ENTER for the default [${ARK_WEBHOOKS_HOST}]: " inputHost
        read -p "Enter the Webhooks API port, or press ENTER for the default [${ARK_WEBHOOKS_PORT}]: " inputPort

        if [[ ! -z "$inputHost" ]]; then
            sed -i -e "s/ARK_WEBHOOKS_HOST=$ARK_WEBHOOKS_HOST/ARK_WEBHOOKS_HOST=$inputHost/g" "$envFile"
        fi

        if [[ ! -z "$inputPort" ]]; then
            sed -i -e "s/ARK_WEBHOOKS_PORT=$ARK_WEBHOOKS_PORT/ARK_WEBHOOKS_PORT=$inputPort/g" "$envFile"
        fi
    fi

    # @arkecosystem/core-graphql
    read -p "Would you like to configure the GraphQL API? [y/N] : " choice

    if [[ "$choice" =~ ^(yes|y|Y) ]]; then
        read -p "Enter the GraphQL API host, or press ENTER for the default [${ARK_GRAPHQL_HOST}]: " inputHost
        read -p "Enter the GraphQL API port, or press ENTER for the default [${ARK_GRAPHQL_PORT}]: " inputPort

        if [[ ! -z "$inputHost" ]]; then
            sed -i -e "s/ARK_GRAPHQL_HOST=$ARK_GRAPHQL_HOST/ARK_GRAPHQL_HOST=$inputHost/g" "$envFile"
        fi

        if [[ ! -z "$inputPort" ]]; then
            sed -i -e "s/ARK_GRAPHQL_PORT=$ARK_GRAPHQL_PORT/ARK_GRAPHQL_PORT=$inputPort/g" "$envFile"
        fi
    fi

    # @arkecosystem/core-json-rpc
    read -p "Would you like to configure the JSON-RPC API? [y/N] : " choice

    if [[ "$choice" =~ ^(yes|y|Y) ]]; then
        read -p "Enter the JSON-RPC host, or press ENTER for the default [${ARK_JSONRPC_HOST}]: " inputHost
        read -p "Enter the JSON-RPC port, or press ENTER for the default [${ARK_JSONRPC_PORT}]: " inputPort

        if [[ ! -z "$inputHost" ]]; then
            sed -i -e "s/ARK_JSONRPC_HOST=$ARK_JSONRPC_HOST/ARK_JSONRPC_HOST=$inputHost/g" "$envFile"
        fi

        if [[ ! -z "$inputPort" ]]; then
            sed -i -e "s/ARK_JSONRPC_PORT=$ARK_JSONRPC_PORT/ARK_JSONRPC_PORT=$inputPort/g" "$envFile"
        fi
    fi

}
