#!/usr/bin/env bash

core_install ()
{
    ascii

    if [[ -d "$CORE_DIR" ]]; then
        error "We found an existing ARK Core installation! Please use the uninstall option first."
    else
        heading "Installing ARK Core..."

        sudo mkdir "$CORE_DIR" >> "$commander_config"
        sudo chown "$USER":"$USER" "$CORE_DIR" >> "$commander_config"
        sudo rm -rf "$CORE_DIR" >> "$commander_config"
        git clone "$CORE_REPO" "$CORE_DIR" >> "$commander_config"
        cd "$CORE_DIR"
        lerna bootstrap >> "$commander_config"

        core_configure

        success "Installed ARK Core!"
    fi
}
