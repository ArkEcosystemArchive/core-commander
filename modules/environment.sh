#!/usr/bin/env bash

setup_environment_directories ()
{
    mkdir -p "$CORE_PATH_DATA"
    mkdir -p "$CORE_PATH_CONFIG"
    mkdir -p "$CORE_PATH_CACHE"
    mkdir -p "$CORE_PATH_LOG"
    mkdir -p "$CORE_PATH_TEMP"
}

setup_environment ()
{
    set_locale

    if [[ ! -f "$commander_config" ]]; then
        ascii

        install_base_dependencies
        install_program_dependencies
        install_nodejs_dependencies
        install_system_updates

        # create ~/.commander
        touch "$commander_config"

        echo "CORE_REPO=https://github.com/ArkEcosystem/core" >> "$commander_config" 2>&1
        echo "CORE_BRANCH=master" >> "$commander_config" 2>&1
        echo "CORE_DIR=${HOME}/core" >> "$commander_config" 2>&1
        echo "CORE_TOKEN=ark" >> "$commander_config" 2>&1
        echo "CORE_NETWORK=mainnet" >> "$commander_config" 2>&1
        echo "EXPLORER_REPO=https://github.com/ArkEcosystem/explorer" >> "$commander_config" 2>&1
        echo "EXPLORER_DIR=${HOME}/ark-explorer" >> "$commander_config" 2>&1

        . "$commander_config"

        # add core paths to ~/.commander
        local CORE_PATHS=$(node ${commander_dir}/utils/paths.js ${CORE_TOKEN} ${CORE_NETWORK})

        CORE_PATH_DATA=$(echo $CORE_PATHS | jq -r ".data")
        CORE_PATH_CONFIG=$(echo $CORE_PATHS | jq -r ".config")
        CORE_PATH_CACHE=$(echo $CORE_PATHS | jq -r ".cache")
        CORE_PATH_LOG=$(echo $CORE_PATHS | jq -r ".log")
        CORE_PATH_TEMP=$(echo $CORE_PATHS | jq -r ".temp")

        echo "CORE_PATH_DATA=${CORE_PATH_DATA}" >> "$commander_config" 2>&1
        echo "CORE_PATH_CONFIG=${CORE_PATH_CONFIG}" >> "$commander_config" 2>&1
        echo "CORE_PATH_CACHE=${CORE_PATH_CACHE}" >> "$commander_config" 2>&1
        echo "CORE_PATH_LOG=${CORE_PATH_LOG}" >> "$commander_config" 2>&1
        echo "CORE_PATH_TEMP=${CORE_PATH_TEMP}" >> "$commander_config" 2>&1

        # create ${CORE_PATH_CONFIG}/.env
        setup_environment_directories
        success "All system dependencies have been installed!"

        check_and_recommend_reboot
        press_to_continue
    fi

    if [[ -e "$commander_config" ]]; then
        install_commander_dependencies

        . "$commander_config"

        local CORE_PATHS=$(node ${commander_dir}/utils/paths.js ${CORE_TOKEN} ${CORE_NETWORK})

        if ! grep -q "CORE_REPO" "${commander_config}"; then
            echo "CORE_REPO=https://github.com/ArkEcosystem/core" >> "$commander_config" 2>&1
        fi

        if ! grep -q "CORE_BRANCH" "${commander_config}"; then
            echo "CORE_BRANCH=master" >> "$commander_config" 2>&1
        fi

        if ! grep -q "CORE_DIR" "${commander_config}"; then
            echo "CORE_DIR=${HOME}/ark-core" >> "$commander_config" 2>&1
        fi

        if ! grep -q "CORE_PATH_DATA" "${commander_config}"; then
            local CORE_PATH_DATA=$(echo $CORE_PATHS | jq -r ".data")

            echo "CORE_PATH_DATA=${CORE_PATH_DATA}" >> "$commander_config" 2>&1
        fi

        if ! grep -q "CORE_PATH_CONFIG" "${commander_config}"; then
            local CORE_PATH_CONFIG=$(echo $CORE_PATHS | jq -r ".config")

            echo "CORE_PATH_CONFIG=${CORE_PATH_CONFIG}" >> "$commander_config" 2>&1
        fi

        if ! grep -q "CORE_PATH_CACHE" "${commander_config}"; then
            local CORE_PATH_CACHE=$(echo $CORE_PATHS | jq -r ".cache")

            echo "CORE_PATH_CACHE=${CORE_PATH_CACHE}" >> "$commander_config" 2>&1
        fi

        if ! grep -q "CORE_PATH_LOG" "${commander_config}"; then
            local CORE_PATH_LOG=$(echo $CORE_PATHS | jq -r ".log")

            echo "CORE_PATH_LOG=${CORE_PATH_LOG}" >> "$commander_config" 2>&1
        fi

        if ! grep -q "CORE_PATH_TEMP" "${commander_config}"; then
            local CORE_PATH_TEMP=$(echo $CORE_PATHS | jq -r ".temp")

            echo "CORE_PATH_TEMP=${CORE_PATH_TEMP}" >> "$commander_config" 2>&1
        fi

        if ! grep -q "CORE_TOKEN" "${commander_config}"; then
            echo "CORE_TOKEN=ark" >> "$commander_config" 2>&1
        fi

        if ! grep -q "CORE_NETWORK" "${commander_config}"; then
            echo "CORE_NETWORK=mainnet" >> "$commander_config" 2>&1
        fi

        if ! grep -q "EXPLORER_REPO" "${commander_config}"; then
            echo "EXPLORER_REPO=https://github.com/ArkEcosystem/explorer" >> "$commander_config" 2>&1
        fi

        if ! grep -q "EXPLORER_DIR" "${commander_config}"; then
            echo "EXPLORER_DIR=${HOME}/ark-explorer" >> "$commander_config" 2>&1
        fi

        . "$commander_config"

        setup_environment_directories
    fi
}
