#!/usr/bin/env bash

menu_manage_forger ()
{
    ascii

    forger_status

    if [[ "$STATUS_FORGER" = "On" ]]; then
        text_white "    K. Stop Forger"
        text_white "    R. Restart Forger"
    else
        text_white "    S. Start Forger"
        text_white "    C. Configure Forger"
    fi

    text_white "    L. Show Log"

    divider

    text_white "    H. Show Help"

    divider

    text_white "    X. Back to Main Menu"

    divider

    menu_manage_forger_parse_args
}
