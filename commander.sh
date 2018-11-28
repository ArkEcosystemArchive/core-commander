#!/usr/bin/env bash

# -------------------------
# Variables
# -------------------------

commander=$(basename "$0")
commander_dir="$(cd "$(dirname "$0")" && pwd)"
commander_log="${commander_dir}/logs/commander.log"
commander_ecosystem="${commander_dir}/ecosystem.config.js"
commander_config="${HOME}/.commander"

# -------------------------
# Helpers
# -------------------------

. "${commander_dir}/helpers/typography.sh"
. "${commander_dir}/helpers/continue.sh"
. "${commander_dir}/helpers/reboot.sh"
. "${commander_dir}/helpers/pm2status.sh"
. "${commander_dir}/helpers/errors.sh"
. "${commander_dir}/helpers/core.sh"

# -------------------------
# Scripts
# -------------------------

. "${commander_dir}/scripts/locale.sh"
. "${commander_dir}/scripts/nodejs.sh"
. "${commander_dir}/scripts/ntp.sh"
. "${commander_dir}/scripts/pm2.sh"
. "${commander_dir}/scripts/postgresql.sh"
. "${commander_dir}/scripts/yarn.sh"

# -------------------------
# Menus
# -------------------------

. "${commander_dir}/menus/ascii.sh"

# -------------------------
# Modules
# -------------------------

. "${commander_dir}/modules/bootstrap.sh"
. "${commander_dir}/modules/environment.sh"
. "${commander_dir}/modules/modifications.sh"
. "${commander_dir}/modules/versions.sh"
. "${commander_dir}/modules/state.sh"
. "${commander_dir}/modules/update.sh"
. "${commander_dir}/modules/processes.sh"
. "${commander_dir}/modules/database.sh"
. "${commander_dir}/modules/dependencies.sh"

# -------------------------
# Actions
# -------------------------

. "${commander_dir}/actions/apps/commander.sh"
. "${commander_dir}/actions/apps/explorer.sh"
. "${commander_dir}/actions/apps/forger.sh"
. "${commander_dir}/actions/apps/relay.sh"
. "${commander_dir}/actions/core/configure/database.sh"
. "${commander_dir}/actions/core/configure/hosts-and-ports.sh"
. "${commander_dir}/actions/core/configure/log-level.sh"
. "${commander_dir}/actions/core/configure.sh"
. "${commander_dir}/actions/core/install.sh"
. "${commander_dir}/actions/core/uninstall.sh"
. "${commander_dir}/actions/core/update.sh"
. "${commander_dir}/actions/miscellaneous/alias.sh"
. "${commander_dir}/actions/miscellaneous/executable.sh"
. "${commander_dir}/actions/miscellaneous/updates.sh"
. "${commander_dir}/actions/log.sh"
. "${commander_dir}/actions/process_monitor.sh"

# -------------------------
# Menus - Items
# -------------------------

. "${commander_dir}/menus/commander/help.sh"
. "${commander_dir}/menus/commander/args.sh"
. "${commander_dir}/menus/commander/menu.sh"
. "${commander_dir}/menus/core/help.sh"
. "${commander_dir}/menus/core/args.sh"
. "${commander_dir}/menus/core/menu.sh"
. "${commander_dir}/menus/explorer/help.sh"
. "${commander_dir}/menus/explorer/args.sh"
. "${commander_dir}/menus/explorer/menu.sh"
. "${commander_dir}/menus/forger/help.sh"
. "${commander_dir}/menus/forger/args.sh"
. "${commander_dir}/menus/forger/menu.sh"
. "${commander_dir}/menus/miscellaneous/help.sh"
. "${commander_dir}/menus/miscellaneous/args.sh"
. "${commander_dir}/menus/miscellaneous/menu.sh"
. "${commander_dir}/menus/relay/help.sh"
. "${commander_dir}/menus/relay/args.sh"
. "${commander_dir}/menus/relay/menu.sh"
. "${commander_dir}/menus/main/help.sh"
. "${commander_dir}/menus/main/args.sh"
. "${commander_dir}/menus/main/menu.sh"

# -------------------------
# Start
# -------------------------

main ()
{
    setup_environment
    miscellaneous_install_updates
    commander_update

    if [[ -d "$CORE_DIR" ]]; then
        core_update
    else
        STATUS_CORE_UPDATE="n/a"
    fi

    if [[ -d "$EXPLORER_DIR" ]]; then
        explorer_update
    else
        STATUS_EXPLORER_UPDATE="n/a"
    fi

    while true; do
        menu_main
    done

    trap cleanup SIGINT SIGTERM SIGKILL
}

main "$@"
