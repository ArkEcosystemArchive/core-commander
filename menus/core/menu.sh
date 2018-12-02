#!/usr/bin/env bash

menu_manage_core ()
{
    ascii

    forger_status
    relay_status

    text_white "    U. Update Ark Core"
    text_white "    P. Uninstall Ark Core"
    text_white "    C. Configure Ark Core"

    divider

    text_white "    L. Configure Log Level"
    text_white "    D. Configure Database"
    text_white "    A. Configure Hosts & Ports"
    text_white "    R. Reset Configuration"

    divider

    text_white "    H. Show Help"

    divider

    text_white "    X. Back to Main Menu"

    divider

    menu_manage_core_parse_args
}
