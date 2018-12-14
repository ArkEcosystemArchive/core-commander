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

        info "You already have the latest supported Ark Core version."
    else
        STATUS_CORE_UPDATE="Yes"

        read -p "An update is available for Ark Core, do you want to install it? [Y/n] : " choice

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
            git checkout "$CORE_BRANCH" | tee -a "$commander_log"
            git pull | tee -a "$commander_log"
            yarn setup

            # Make sure the git commit hash is not modified by a local yarn.lock
            git reset --hard | tee -a "$commander_log"

            check_for_modifications "packages/core/src/config/${CORE_NETWORK}/plugins.js" "${CORE_CONFIG}/plugins.js"
            check_for_modifications "packages/crypto/src/networks/${CORE_TOKEN}/${CORE_NETWORK}.json" "${CORE_CONFIG}/network.json"

            # Make sure we have the latest peers lists and sources
            rm -f "${CORE_CONFIG}/peers.json"
            rm -f "${CORE_CONFIG}/peers_backup.json"
            cp -r "${CORE_DIR}/packages/core/src/config/${CORE_NETWORK}/peers.json" "${CORE_CONFIG}/peers.json"

            if [[ "$relay_on" = "On" ]]; then
                relay_start
            fi

            if [[ "$forger_on" = "On" ]]; then
                forger_start
            fi

            success "Update OK!"
            STATUS_CORE_UPDATE="No"

            core_version
        fi
    fi
}
