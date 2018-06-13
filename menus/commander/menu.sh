#!/usr/bin/env bash

menu_manage_commander ()
{
    ascii

    explorer_status

    text_white "    R. Configure Core Repository"
    text_white "    A. Configure Core Directory"
    text_white "    D. Configure Core Data Directory"
    text_white "    C. Configure Core Config Directory"

    divider

    text_white "    T. Configure Token"
    text_white "    N. Configure Token Network"

    divider

    text_white "    S. Configure Explorer Repository"
    text_white "    E. Configure Explorer Directory"

    divider

    text_white "    H. Show Help"

    divider

    text_white "    X. Back to Main Menu"

    divider

    menu_manage_commander_parse_args
}
