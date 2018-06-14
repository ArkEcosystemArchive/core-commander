#!/usr/bin/env bash

menu_manage_commander_help ()
{
    ascii

    text_yellow "    Configure Core Repository (R)"
    text_white "    you can change the core repository path with a different Github repo (if you want to pull Core code from a custom path)."
    echo

    text_yellow "    Configure Core Directory (A)"
    text_white "    lets you configure the directory core is installed into when you select Install ARK Core (you can change this before you start the core installation)."
    echo

    text_yellow "    Configure Core Data Directory (D)"
    text_white "    lets you configure the data directory (where things like the database and logs go)."
    echo

    text_yellow "    Configure Core Config Directory (C)"
    text_white "    lets you configure the config directory (where your configuration files go)."
    echo

    text_yellow "    Configure Token (T)"
    text_white "    lets you configure a different custom token (ARK by default)."
    echo

    text_yellow "    Configure Token Network (N)"
    text_white "    lets you configure a different custom token network (devnet by default)."
    echo

    text_yellow "    Configure Explorer Repository (S)"
    text_white "    you can change the Explorer repository path with a different Github repo (if you want to pull Explorer code from a custom repo)."
    echo

    text_yellow "    Configure Explorer Directory (E)"
    text_white "    lets you configure the directory where the Explorer is installed into when you do an ARK Explorer installation (you can change this before you start the explorer installation)."
    echo

    text_yellow "    Show Help (H)"
    text_white "    opens the help file where all this information is available."

    divider

    text_blue "    For more information head on over to https://docs.ark.io/"
    echo

    press_to_continue

    menu_main
}
