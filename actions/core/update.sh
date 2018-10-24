#!/usr/bin/env bash

core_update ()
{
    ascii

    cd "$CORE_DIR"

    git fetch

    local origin=$(git rev-parse --symbolic-full-name --abbrev-ref HEAD)
    local remote_version=$(git rev-parse origin/"$origin")
    local local_version=$(git rev-parse HEAD)

    if [[ "$remote_version" == "$local_version" ]]; then
        STATUS_CORE_UPDATE="No"

        info "You already have the latest ARK Core version that we support."
    else
        STATUS_CORE_UPDATE="Yes"

        read -p "An update is available for ARK Core, do you want to install it? [Y/n] : " choice

        if [[ -z "$choice" || "$choice" =~ ^(yes|y|Y) ]]; then
            relay_status
            forger_status

            local relay_on=$STATUS_RELAY
            local forger_on=$STATUS_FORGER

            if [[ "$relay_on" = "On" ]]; then
                relay_stop
            fi

            if [[ "$forger_on" = "On" ]]; then
                forger_stop
            fi

            heading "Starting Update..."
            git reset --hard | tee -a "$commander_log"
            git checkout develop | tee -a "$commander_log"
            git pull | tee -a "$commander_log"
            lerna bootstrap

            # plugins.js
            plugins_local_checksum=$(sha256sum "${CORE_CONFIG}/plugins.js" | awk '{ print $1 }')
            plugins_remote_checksum=$(sha256sum "${CORE_DIR}/packages/core/lib/config/${CORE_NETWORK}/plugins.js" | awk '{ print $1 }')

            if [[ "$plugins_local_checksum" != "$plugins_remote_checksum" ]]; then
                read -p "${CORE_CONFIG}/plugins.js has been modified in the latest update, do you want to replace it? THIS WILL REMOVE ANY MODIFICATIONS! [Y/n] : " choice

                if [[ -z "$choice" || "$choice" =~ ^(yes|y|Y) ]]; then
                    cp -f "${CORE_DIR}/packages/core/lib/config/${CORE_NETWORK}/plugins.js" "${CORE_CONFIG}/plugins.js"
                fi
            fi

            # network.json
            network_local_checksum=$(sha256sum "${CORE_CONFIG}/network.json" | awk '{ print $1 }')
            network_remote_checksum=$(sha256sum "${CORE_DIR}/packages/crypto/lib/networks/${CORE_TOKEN}/${CORE_NETWORK}.json" | awk '{ print $1 }')

            if [[ "$network_local_checksum" != "$network_remote_checksum" ]]; then
                read -p "${CORE_CONFIG}/network.json has been modified in the latest update, do you want to replace it? THIS WILL REMOVE ANY MODIFICATIONS! [Y/n] : " choice

                if [[ -z "$choice" || "$choice" =~ ^(yes|y|Y) ]]; then
                    cp -f "${CORE_DIR}/packages/crypto/lib/networks/${CORE_TOKEN}/${CORE_NETWORK}.json" "${CORE_CONFIG}/network.json"
                fi
            fi

            if [[ "$relay_on" = "On" ]]; then
                relay_start
            fi

            if [[ "$forger_on" = "On" ]]; then
                forger_start
            fi

            success "Update OK!"
            STATUS_CORE_UPDATE="No"
        fi
    fi
}
