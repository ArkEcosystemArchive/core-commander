#!/usr/bin/env bash

setup_environment ()
{
    sudo echo "Requesting sudo permissions for $USER"

    sudo updatedb

    set_locale

    if [[ $(systemd-detect-virt) == "lxc" ]] || [[ $(systemd-detect-virt) == "openvz" ]]; then
        CONTAINER=1
    else
        CONTAINER=0
    fi

    if [[ ! -f "$commander_config" ]]; then
        ascii

        install_base_dependencies
        install_program_dependencies
        install_nodejs_dependencies
        install_system_updates

        # create ~/.commander
        touch "$commander_config"

        echo "CORE_REPO=https://github.com/ArkEcosystem/core" >> "$commander_log"
        echo "CORE_DIR=${HOME}/ark-core" >> "$commander_log"
        echo "CORE_DATA=${HOME}/.ark" >> "$commander_log"
        echo "CORE_CONFIG=${HOME}/.ark/config" >> "$commander_log"
        echo "CORE_TOKEN=ark" >> "$commander_log"
        echo "CORE_NETWORK=devnet" >> "$commander_log"
        echo "EXPLORER_REPO=https://github.com/ArkEcosystem/explorer" >> "$commander_log"
        echo "EXPLORER_DIR=${HOME}/ark-explorer" >> "$commander_log"

        . "$commander_config"

        # create ~/.ark/.env
        mkdir "${HOME}/.ark"
        local envFile="${HOME}/.ark/.env"
        touch "$envFile"

        echo "ARK_DB_HOST=localhost" >> "$envFile"
        echo "ARK_DB_USERNAME=ark" >> "$envFile"
        echo "ARK_DB_PASSWORD=password" >> "$envFile"
        echo "ARK_DB_DATABASE=ark_devnet" >> "$envFile"

        success "All system dependencies have been installed! The system will restart now."

        press_to_continue

        sudo reboot
    fi

    if [[ -e "$commander_config" ]]; then
        . "$commander_config"
    fi
}
