#!/usr/bin/env bash

core_configure_reset ()
{
    read -p "Are you sure you want to reset the configuration? [y/N] : " choice

    if [[ "$choice" =~ ^(yes|y|Y) ]]; then
        info "Resetting configuration..."

        __core_configure_core "${CORE_NETWORK}"

        info "Reset configuration!"
    else
        warning "Skipping configuration reset..."
    fi
}

core_configure ()
{
    ascii

    local configured=false

    if [[ -d "$CORE_PATH_CONFIG" ]]; then
        read -p "We found an Ark Core configuration, do you want to overwrite it? [y/N] : " choice

        if [[ "$choice" =~ ^(yes|y|Y) ]]; then
            __core_configure_pre

            rm -rf "$CORE_PATH_CONFIG"

            __core_configure_network

            core_configure_database

            core_configure_log_level

            __core_configure_post

            configured=true
        else
            warning "Skipping configuration..."
        fi
    else
        __core_configure_pre

        __core_configure_network

        core_configure_database

        core_configure_log_level

        __core_configure_post

        configured=true
    fi

    if [[ "$configured" = true ]]; then
        read -p "Ark Core has been configured, would you like to start the relay? [Y/n] : " choice

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

    yarn setup | tee -a "$commander_log"

    # Make sure the git commit hash is not modified by a local yarn.lock
    git reset --hard | tee -a "$commander_log"
}

__core_configure_network ()
{
    ascii

    info "Which network would you like to configure?"

    validNetworks=("mainnet" "devnet" "testnet")

    select opt in "${validNetworks[@]}"; do
        case "$opt" in
            "mainnet")
                __core_configure_commander "mainnet"
                __core_configure_branch "master"
                __core_configure_core "mainnet"
                __core_configure_environment "mainnet"
                break
            ;;
            "devnet")
                __core_configure_commander "devnet"
                __core_configure_branch "develop"
                __core_configure_core "devnet"
                __core_configure_environment "devnet"
                break
            ;;
            "testnet")
                __core_configure_commander "testnet"
                __core_configure_branch "develop"
                __core_configure_core "testnet"
                __core_configure_environment "testnet"
                break
            ;;
            *)
                echo "Invalid option $REPLY"
            ;;
        esac
    done

    . "$commander_config"
}

__core_configure_commander ()
{
    sed -i -e "s/CORE_NETWORK=$CORE_NETWORK/CORE_NETWORK=$1/g" "$commander_config"

    __commander_configure_environment "$1"

    mkdir -p "$CORE_PATH_DATA"
    mkdir -p "$CORE_PATH_CONFIG"
    mkdir -p "$CORE_PATH_CACHE"
    mkdir -p "$CORE_PATH_LOG"
    mkdir -p "$CORE_PATH_TEMP"
}

__core_configure_core ()
{
    cp -rf "${CORE_DIR}/packages/core/src/config/$1/." "${CORE_PATH_CONFIG}"
}

__core_configure_environment ()
{
    heading "Creating Environment configuration..."

    local envFile="${CORE_PATH_CONFIG}/.env"

    touch "$envFile"

    if [[ "$1" = "mainnet" ]]; then
        grep -q '^CORE_LOG_LEVEL' "${envFile}" 2>&1 || echo "CORE_LOG_LEVEL=info" >> "$envFile" 2>&1
    fi

    if [[ "$1" = "devnet" ]]; then
        grep -q '^CORE_LOG_LEVEL' "${envFile}" 2>&1 || echo "CORE_LOG_LEVEL=debug" >> "$envFile" 2>&1
    fi

    if [[ "$1" = "testnet" ]]; then
        grep -q '^CORE_LOG_LEVEL' "${envFile}" 2>&1 || echo "CORE_LOG_LEVEL=debug" >> "$envFile" 2>&1
    fi

    grep -q '^CORE_DB_HOST' "${envFile}" 2>&1 || echo "CORE_DB_HOST=localhost" >> "$envFile" 2>&1
    grep -q '^CORE_DB_PORT' "${envFile}" 2>&1 || echo "CORE_DB_PORT=5432" >> "$envFile" 2>&1
    grep -q '^CORE_DB_USERNAME' "${envFile}" 2>&1 || echo "CORE_DB_USERNAME=${USER}" >> "$envFile" 2>&1
    grep -q '^CORE_DB_PASSWORD' "${envFile}" 2>&1 || echo "CORE_DB_PASSWORD=password" >> "$envFile" 2>&1
    grep -q '^CORE_DB_DATABASE' "${envFile}" 2>&1 || echo "CORE_DB_DATABASE=ark_$1" >> "$envFile" 2>&1

    grep -q '^CORE_P2P_HOST' "$envFile" 2>&1 || echo 'CORE_P2P_HOST=0.0.0.0' >> "$envFile" 2>&1

    if [[ "$1" = "mainnet" ]]; then
        grep -q '^CORE_P2P_PORT' "$envFile" 2>&1 || echo 'CORE_P2P_PORT=4001' >> "$envFile" 2>&1
    fi

    if [[ "$1" = "devnet" ]]; then
        grep -q '^CORE_P2P_PORT' "$envFile" 2>&1 || echo 'CORE_P2P_PORT=4002' >> "$envFile" 2>&1
    fi

    if [[ "$1" = "testnet" ]]; then
        grep -q '^CORE_P2P_PORT' "$envFile" 2>&1 || echo 'CORE_P2P_PORT=4000' >> "$envFile" 2>&1
    fi

    grep -q '^CORE_API_HOST' "$envFile" 2>&1 || echo 'CORE_API_HOST=0.0.0.0' >> "$envFile" 2>&1
    grep -q '^CORE_API_PORT' "$envFile" 2>&1 || echo 'CORE_API_PORT=4003' >> "$envFile" 2>&1

    grep -q '^CORE_WEBHOOKS_HOST' "$envFile" 2>&1 || echo 'CORE_WEBHOOKS_HOST=0.0.0.0' >> "$envFile" 2>&1
    grep -q '^CORE_WEBHOOKS_PORT' "$envFile" 2>&1 || echo 'CORE_WEBHOOKS_PORT=4004' >> "$envFile" 2>&1

    grep -q '^CORE_GRAPHQL_HOST' "$envFile" 2>&1 || echo 'CORE_GRAPHQL_HOST=0.0.0.0' >> "$envFile" 2>&1
    grep -q '^CORE_GRAPHQL_PORT' "$envFile" 2>&1 || echo 'CORE_GRAPHQL_PORT=4005' >> "$envFile" 2>&1

    grep -q '^CORE_JSON_RPC_HOST' "$envFile" 2>&1 || echo 'CORE_JSON_RPC_HOST=0.0.0.0' >> "$envFile" 2>&1
    grep -q '^CORE_JSON_RPC_PORT' "$envFile" 2>&1 || echo 'CORE_JSON_RPC_PORT=8080' >> "$envFile" 2>&1

    success "Created Environment configuration!"
}

__core_configure_branch ()
{
    heading "Changing git branch..."

    sed -i -e "s/CORE_BRANCH=$CORE_BRANCH/CORE_BRANCH=$1/g" "$commander_config"
    . "${commander_config}"

    cd "$CORE_DIR"
    git reset --hard | tee -a "$commander_log"
    git pull | tee -a "$commander_log"
    git checkout "$1" | tee -a "$commander_log"

    success "Changed git branch!"
}
