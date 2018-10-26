#!/usr/bin/env bash

setup_environment_file ()
{
    if [[ ! -e "${CORE_DATA}/.env" ]]; then
        mkdir "${HOME}/.ark"
        local envFile="${CORE_DATA}/.env"
        touch "$envFile"

        echo "ARK_LOG_LEVEL=debug" >> "$envFile" 2>&1

        echo "ARK_DB_HOST=localhost" >> "$envFile" 2>&1
        echo "ARK_DB_PORT=5432" >> "$envFile" 2>&1
        echo "ARK_DB_USERNAME=${USER}" >> "$envFile" 2>&1
        echo "ARK_DB_PASSWORD=password" >> "$envFile" 2>&1
        echo "ARK_DB_DATABASE=ark_devnet" >> "$envFile" 2>&1
    fi

    . "${CORE_DATA}/.env"
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
        echo "CORE_DIR=${HOME}/ark-core" >> "$commander_config" 2>&1
        echo "CORE_DATA=${HOME}/.ark" >> "$commander_config" 2>&1
        echo "CORE_CONFIG=${HOME}/.ark/config" >> "$commander_config" 2>&1
        echo "CORE_TOKEN=ark" >> "$commander_config" 2>&1
        echo "CORE_NETWORK=devnet" >> "$commander_config" 2>&1
        echo "EXPLORER_REPO=https://github.com/ArkEcosystem/explorer" >> "$commander_config" 2>&1
        echo "EXPLORER_DIR=${HOME}/ark-explorer" >> "$commander_config" 2>&1

        . "$commander_config"

        # create ~/.ark/.env
        setup_environment_file
        success "All system dependencies have been installed!"

        check_and_recommend_reboot
        press_to_continue
    fi

    if [[ -e "$commander_config" ]]; then
        . "$commander_config"

        setup_environment_file
    fi
}
