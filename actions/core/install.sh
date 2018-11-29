#!/usr/bin/env bash

core_install ()
{
    ascii

    if [[ -d "$CORE_DIR" ]]; then
        error "We found an existing Ark Core installation! Please use the uninstall option first."
    else
        heading "Installing Ark Core..."

        # Prepare
        sudo mkdir "$CORE_DIR" >> "$commander_log" 2>&1
        sudo chown "$USER":"$USER" "$CORE_DIR" >> "$commander_log" 2>&1
        sudo rm -rf "$CORE_DIR" >> "$commander_log" 2>&1

        # Clone
        git clone "$CORE_REPO" "$CORE_DIR" | tee -a "$commander_log"
        cd "$CORE_DIR"
        git checkout "$CORE_BRANCH" | tee -a "$commander_log"

        # Configure
        core_configure

        ascii

        success "Installed Ark Core!"

        core_version
    fi
}
