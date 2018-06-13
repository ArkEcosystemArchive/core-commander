#!/usr/bin/env bash

commander_update ()
{
    cd "$commander_dir"

    local remote_version=$(git rev-parse origin/master)
    local local_version=$(git rev-parse HEAD)

    if [[ "$remote_version" == "$local_version" ]]; then
        STATUS_COMMANDER_UPDATE="No"

        info "You already have the latest ARK Commander version that we support."
    else
        STATUS_COMMANDER_UPDATE="Yes"

        read -p "An update is available for ARK Commander, do you want to install it? [Y/n] : " choice

        if [[ "$choice" =~ ^(yes|y|Y) ]]; then
            heading "Starting Update..."
            git reset --hard >> "$commander_log" 2>&1
            git pull >> "$commander_log" 2>&1
            success "Update OK!"

            STATUS_COMMANDER_UPDATE="No"

            press_to_continue
        fi
    fi
}
