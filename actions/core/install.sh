#!/usr/bin/env bash

core_install ()
{
    ascii

    if [[ -d "$CORE_DIR" ]]; then
        error "We found an existing ARK Core installation! Please use the uninstall option first."
    else
        heading "Installing ARK Core..."

        sudo mkdir "$CORE_DIR" >> "$commander_log" 2>&1
        sudo chown "$USER":"$USER" "$CORE_DIR" >> "$commander_log" 2>&1
        sudo rm -rf "$CORE_DIR" >> "$commander_log" 2>&1
        git clone "$CORE_REPO" "$CORE_DIR" | tee -a "$commander_log"
        git checkout develop | tee -a "$commander_log"
        cd "$CORE_DIR"
        lerna bootstrap | tee -a "$commander_log"

        core_configure

        success "Installed ARK Core!"
    fi
}
