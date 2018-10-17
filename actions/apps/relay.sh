#!/usr/bin/env bash

relay_start ()
{
    ascii

    heading "Starting Relay..."

    pm2 start $commander_ecosystem --only ark-core-relay >> "$commander_log" 2>&1

    relay_status

    success "Started Relay!"
}

relay_restart ()
{
    ascii

    heading "Restarting Relay..."

    pm2 restart $commander_ecosystem --only ark-core-relay >> "$commander_log" 2>&1

    relay_status

    success "Restarted Relay!"
}

relay_stop ()
{
    ascii

    heading "Stopping Relay..."

    pm2 stop $commander_ecosystem --only ark-core-relay >> "$commander_log" 2>&1

    relay_status

    success "Stopped Relay!"
}

relay_delete ()
{
    ascii

    local delete_forger=$(pm2status 'ark-core-relay' | awk '{print $2}')
    if [[ -n $delete_forger ]]; then
        heading "Deleting Relay..."

        pm2 delete $commander_ecosystem --only ark-core-relay >> "$commander_log" 2>&1

        relay_status

        success "Deleted Relay!"
    fi
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
    local status=$(pm2status "ark-core-relay" | awk '{print $13}')

    if [[ "$status" == "online" ]]; then
        STATUS_RELAY="On"
    else
        STATUS_RELAY="Off"
    fi
}
