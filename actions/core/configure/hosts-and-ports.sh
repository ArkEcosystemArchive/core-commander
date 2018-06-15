#!/usr/bin/env bash

core_configure_hosts_and_ports ()
{
    # @arkecosystem/core-p2p
    read -p "Would you like to configure the P2P API? [y/N] : " choice

    if [[ "$choice" =~ ^(yes|y|Y) ]]; then
        read -p "Enter the P2P API host, or press ENTER for the default [0.0.0.0]: " inputHost
        read -p "Enter the P2P API port, or press ENTER for the default [4002]: " inputPort

        echo "ARK_P2P_HOST=$inputHost" >> "$envFile" 2>&1
        echo "ARK_P2P_PORT=$inputPort" >> "$envFile" 2>&1
    fi

    # @arkecosystem/core-api
    read -p "Would you like to configure the Public API? [y/N] : " choice

    if [[ "$choice" =~ ^(yes|y|Y) ]]; then
        read -p "Enter the Public API host, or press ENTER for the default [0.0.0.0]: " inputHost
        read -p "Enter the Public API port, or press ENTER for the default [4003]: " inputPort

        echo "ARK_API_HOST=$inputHost" >> "$envFile" 2>&1
        echo "ARK_API_PORT=$inputPort" >> "$envFile" 2>&1
    fi

    # @arkecosystem/core-webhooks
    read -p "Would you like to configure the Webhooks API? [y/N] : " choice

    if [[ "$choice" =~ ^(yes|y|Y) ]]; then
        read -p "Enter the Webhooks API host, or press ENTER for the default [0.0.0.0]: " inputHost
        read -p "Enter the Webhooks API port, or press ENTER for the default [4004]: " inputPort

        echo "ARK_WEBHOOKS_HOST=$inputHost" >> "$envFile" 2>&1
        echo "ARK_WEBHOOKS_PORT=$inputPort" >> "$envFile" 2>&1
    fi

    # @arkecosystem/core-graphql
    read -p "Would you like to configure the GraphQL API? [y/N] : " choice

    if [[ "$choice" =~ ^(yes|y|Y) ]]; then
        read -p "Enter the GraphQL API host, or press ENTER for the default [0.0.0.0]: " inputHost
        read -p "Enter the GraphQL API port, or press ENTER for the default [4005]: " inputPort

        echo "ARK_GRAPHQL_HOST=$inputHost" >> "$envFile" 2>&1
        echo "ARK_GRAPHQL_PORT=$inputPort" >> "$envFile" 2>&1
    fi

    # @arkecosystem/core-json-rpc
    read -p "Would you like to configure the JSON-RPC API? [y/N] : " choice

    if [[ "$choice" =~ ^(yes|y|Y) ]]; then
        read -p "Enter the JSON-RPC host, or press ENTER for the default [0.0.0.0]: " inputHost
        read -p "Enter the JSON-RPC port, or press ENTER for the default [8080]: " inputPort

        echo "ARK_JSONRPC_HOST=$inputHost" >> "$envFile" 2>&1
        echo "ARK_JSONRPC_PORT=$inputPort" >> "$envFile" 2>&1
    fi

    # @arkecosystem/core-*
    read -p "Would you like to configure redis? [y/N] : " choice

    if [[ "$choice" =~ ^(yes|y|Y) ]]; then
        read -p "Enter the Redis host, or press ENTER for the default [localhost]: " inputHost
        read -p "Enter the Redis port, or press ENTER for the default [6379]: " inputPort

        echo "ARK_REDIS_HOST=$inputHost" >> "$envFile" 2>&1
        echo "ARK_REDIS_PORT=$inputPort" >> "$envFile" 2>&1
    fi
}
