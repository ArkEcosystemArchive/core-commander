#!/usr/bin/env bash

core_uninstall ()
{
    ascii

    heading "Uninstalling ARK Core..."

    forger_delete

    relay_delete

    database_destroy

    database_drop_user

    # Ensure we are not in a directory we are going to delete
    cd "$commander_dir"

    heading "Deleting Data..."
    sudo rm -rf "$CORE_DIR"
    success "Deleted Data!"

    heading "Deleting Configuration..."
    sudo rm -rf "$CORE_DATA"
    success "Deleted Configuration!"

    success "Uninstalled ARK Core!"
}
