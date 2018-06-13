#!/usr/bin/env bash

menu_manage_relay ()
{
    ascii

    relay_status

    if [[ "$STATUS_RELAY" = "On" ]]; then
        text_white "    K. Stop Relay"
        text_white "    R. Restart Relay"
    else
        text_white "    S. Start Relay"
    fi

    text_white "    L. Show Log"

    divider

    text_white "    H. Show Help"

    divider

    text_white "    X. Back to Main Menu"

    divider

    menu_manage_relay_parse_args
}
