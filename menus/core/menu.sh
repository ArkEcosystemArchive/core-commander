#!/usr/bin/env bash

menu_manage_core ()
{
    ascii

    forger_status

    text_white "    U. Update ARK"
    text_white "    P. Uninstall ARK"
    text_white "    C. Configure ARK"

    divider

    text_white "    H. Show Help"

    divider

    text_white "    X. Back to Main Menu"

    divider

    menu_manage_core_parse_args
}
