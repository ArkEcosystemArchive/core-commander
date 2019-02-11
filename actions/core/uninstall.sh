#!/usr/bin/env bash

core_uninstall ()
{
    ascii

    heading "Uninstalling Ark Core..."

    forger_delete

    relay_delete

    database_destroy

    database_drop_user

    # Ensure we are not in a directory we are going to delete
    cd "$commander_dir"

    heading "Deleting Data..."
    sudo rm -rf "$CORE_DIR"
    success "Deleted Data!"

    heading "Deleting Data..."
    sudo rm -rf "$CORE_PATH_DATA"
    success "Deleted Data!"

    heading "Deleting Configuration..."
    sudo rm -rf "$CORE_PATH_CONFIG"
    success "Deleted Configuration!"

    heading "Deleting Cache..."
    sudo rm -rf "$CORE_PATH_CACHE"
    success "Deleted Cache!"

    heading "Deleting Logs..."
    sudo rm -rf "$CORE_PATH_LOG"
    success "Deleted Logs!"

    heading "Deleting Temp..."
    sudo rm -rf "$CORE_PATH_TEMP"
    success "Deleted Temp!"

    success "Uninstalled Ark Core!"

    core_version
}
