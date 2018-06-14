#!/usr/bin/env bash

relay_start ()
{
    ascii

    heading "Starting Relay..."

    (pm2 start "$CORE_DIR/packages/core/bin/ark" --name ark-core-relay -- relay --data "$CORE_DATA" --config "$CORE_CONFIG" --token "$CORE_TOKEN" --network "$CORE_NETWORK") | tee -a "$commander_log"

    relay_status

    success "Started Relay!"
}

relay_restart ()
{
    ascii

    heading "Restarting Relay..."

    pm2 restart ark-core-relay | tee -a "$commander_log"

    relay_status

    success "Restarted Relay!"
}

relay_stop ()
{
    ascii

    heading "Stopping Relay..."

    pm2 stop ark-core-relay | tee -a "$commander_log"

    relay_status

    success "Stopped Relay!"
}

relay_delete ()
{
    ascii

    heading "Deleting Relay..."

    pm2 delete ark-core-relay | tee -a "$commander_log"

    relay_status

    success "Deleted Relay!"
}

relay_logs ()
{
    clear
    echo -e "\n$(text_yellow " Use Ctrl+C to return to menu")\n"
    trap : INT

    pm2 logs ark-core-relay
}

relay_status ()
{
    local status=$(pm2 status 2>/dev/null | fgrep "ark-core-relay" | awk '{print $10}')

    if [[ "$status" == "online" ]]; then
        STATUS_RELAY="On"
    else
        STATUS_RELAY="Off"
    fi
}
