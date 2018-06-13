#!/usr/bin/env bash

menu_manage_explorer ()
{
    ascii

    explorer_status

    if [[ "$STATUS_EXPLORER" = "On" ]]; then
        text_white "    P. Uninstall ARK Explorer"
        text_white "    K. Stop ARK Explorer"
        text_white "    R. Restart ARK Explorer"
        text_white "    U. Update ARK Explorer"
    else
        if [[ -d "$EXPLORER_DIR" ]]; then
            text_white "    S. Start ARK Explorer"
        else
            text_white "    I. Install ARK Explorer"
        fi

        divider
    fi

    text_white "    L. Show Log"

    divider

    text_white "    H. Show Help"

    divider

    text_white "    X. Back to Main Menu"

    divider

    menu_manage_explorer_parse_args
}
