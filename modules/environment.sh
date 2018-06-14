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

        echo "CORE_REPO=https://github.com/ArkEcosystem/core" | tee -a "$commander_log"
        echo "CORE_DIR=${HOME}/ark-core" | tee -a "$commander_log"
        echo "CORE_DATA=${HOME}/.ark" | tee -a "$commander_log"
        echo "CORE_CONFIG=${HOME}/.ark/config" | tee -a "$commander_log"
        echo "CORE_TOKEN=ark" | tee -a "$commander_log"
        echo "CORE_NETWORK=devnet" | tee -a "$commander_log"
        echo "EXPLORER_REPO=https://github.com/ArkEcosystem/explorer" | tee -a "$commander_log"
        echo "EXPLORER_DIR=${HOME}/ark-explorer" | tee -a "$commander_log"

        . "$commander_config"

        # create ~/.ark/.env
        mkdir "${HOME}/.ark"
        local envFile="${HOME}/.ark/.env"
        touch "$envFile"

        echo "ARK_DB_HOST=localhost" | tee -a "$envFile"
        echo "ARK_DB_USERNAME=ark" | tee -a "$envFile"
        echo "ARK_DB_PASSWORD=password" | tee -a "$envFile"
        echo "ARK_DB_DATABASE=ark_devnet" | tee -a "$envFile"

        success "All system dependencies have been installed! The system will restart now."

        press_to_continue

        sudo reboot
    fi

    if [[ -e "$commander_config" ]]; then
        . "$commander_config"
    fi
}
