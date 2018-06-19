#!/usr/bin/env bash

forger_start ()
{
    ascii

    heading "Starting Forger..."

    local bip38=$(jq -r '.bip38 // empty' "$CORE_CONFIG/delegates.json")

    if [[ -z "$bip38" ]]; then
        __forger_start_without_bip38
    else
        __forger_start_with_bip38
    fi

    forger_status

    success "Started Forger!"
}

forger_restart ()
{
    ascii

    heading "Restarting Forger..."

    pm2 restart ark-core-forger >> "$commander_log" 2>&1

    forger_status

    success "Restarted Forger!"
}

forger_stop ()
{
    ascii

    heading "Stopping Forger..."

    pm2 stop ark-core-forger >> "$commander_log" 2>&1

    forger_status

    success "Stopped Forger!"
}

forger_delete ()
{
    ascii

    local delete_forger=$(pm2status "ark-core-forger" | awk '{print $2}')
    if [[ -n $delete_forger ]]; then
        heading "Deleting Forger..."

        pm2 delete ark-core-forger >> "$commander_log" 2>&1

        forger_status

        success "Deleted Forger!"
    fi
}

forger_logs ()
{
    clear
    echo -e "\n$(text_yellow " Use Ctrl+C to return to menu")\n"
    trap : INT

    pm2 logs ark-core-forger
}

forger_status ()
{
    local status=$(pm2status "ark-core-forger" | awk '{print $10}')

    if [[ "$status" == "online" ]]; then
        STATUS_FORGER="On"
    else
        STATUS_FORGER="Off"
    fi
}

forger_configure ()
{
    ascii

    read -p "Would you like to use secure bip38 encryption? [Y/n] : " choice

    if [[ -z "$choice" || "$choice" =~ ^(yes|y|Y) ]]; then
        __forger_configure_bip38
    else
        __forger_configure_plain
    fi
}

__forger_configure_plain ()
{
    read -sp "Please enter your delegate secret: " inputSecret
    echo

    $(node "$CORE_DIR/packages/core/bin/ark" forger-plain --config "$CORE_CONFIG" --secret "$inputSecret")

    local status=$?

    if [[ $status -ne 0 ]]; then
        error "Sorry, an unknown error occurred. Please try again." >> "$commander_log" 2>&1
    else
        read -p "The forger has been configured, would you like to start the forger? [Y/n] : " choice

        if [[ -z "$choice" || "$choice" =~ ^(yes|y|Y) ]]; then
            forger_start
        fi
    fi
}

__forger_configure_bip38 ()
{
    read -sp "Please enter your delegate secret: " inputSecret
    echo
    read -sp "Please enter your bip38 password: " inputBip38
    echo

    warning "Hang in there while we encrypt your secret..."

    $(node "$CORE_DIR/packages/core/bin/ark" forger-bip38 --config "$CORE_CONFIG" --token "$CORE_TOKEN" --network "$CORE_NETWORK" --secret "$inputSecret" --password "$inputBip38")

    local status=$?

    if [[ $status -ne 0 ]]; then
        error "Sorry, an unknown error occurred. Please try again." >> "$commander_log" 2>&1
    else
        read -p "The forger has been configured, would you like to start the forger? [Y/n] : " choice

        if [[ -z "$choice" || "$choice" =~ ^(yes|y|Y) ]]; then
            forger_start
        fi
    fi
}

__forger_start_with_bip38 ()
{
    local bip38=$(jq -r '.bip38' "$CORE_CONFIG/delegates.json")

    read -sp "Please enter your bip38 password: " password

    pm2 start "$CORE_DIR/packages/core/bin/ark" --name ark-core-forger -- forger --data "$CORE_DATA" --config "$CORE_CONFIG" --token "$CORE_TOKEN" --network "$CORE_NETWORK" --bip38 "$bip38" --password "$password" >> "$commander_log" 2>&1
}

__forger_start_without_bip38 ()
{
    pm2 start "$CORE_DIR/packages/core/bin/ark" --name ark-core-forger -- forger --data "$CORE_DATA" --config "$CORE_CONFIG" --token "$CORE_TOKEN" --network "$CORE_NETWORK" >> "$commander_log" 2>&1
}
