#!/usr/bin/env bash

menu_manage_core_help ()
{
    ascii

    divider

    text_yellow "    Update Ark (U)"
    text_white "    update Ark Core if a new version is available."
    echo

    text_yellow "    Uninstall Ark (P)"
    text_white "    uninstall Ark Core from your system."
    echo

    text_yellow "    Configure Ark (C)"
    text_white "    lets you select a network configuration and automatically creates the database for the config you chose."
    echo

    text_yellow "    Show Help (H)"
    text_white "    opens the help file where all this information is available."

    divider

    text_blue "    For more information head on over to https://docs.ark.io/"
    echo

    press_to_continue

    menu_main
}
