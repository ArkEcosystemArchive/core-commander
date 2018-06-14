#!/usr/bin/env bash

menu_manage_commander_help ()
{
    ascii

    text_yellow "    Configure Core Repository (R)"
    text_white "    you can change the core repository path with a different Github repo (if you want to pull Core code from a custom path)."
    echo

    text_yellow "    Configure Core Directory (A)"
    text_white "    lets you configure directory core is installed into when you do Install ARK Core (can change before you start core installation)."
    echo

    text_yellow "    Configure Core Data Directory (D)"
    text_white "    lets you configure data directory (where things like database and logs go)."
    echo

    text_yellow "    Configure Core Config Directory (C)"
    text_white "    lets you configure config directory of your configuration files."
    echo

    text_yellow "    Configure Token (T)"
    text_white "    lets you configure different token (ARK by default)."
    echo

    text_yellow "    Configure Token Network (N)"
    text_white "    lets you configure different token network (testnet by default)."
    echo

    text_yellow "    Configure Explorer Repository (S)"
    text_white "    you can change core repository path with different Github repo (if you want to pull Explorer code from custom path)."
    echo

    text_yellow "    Configure Explorer Directory (E)"
    text_white "    lets you configure directory explorer is installed into when you do ARK explorer installation (can change before you start explorer installation)."
    echo

    text_yellow "    Show Help (H)"
    text_white "    opens help file where all this information is available."

    divider

    text_blue "    For more information head over to https://arkdocs.readme.io/"
    echo

    press_to_continue

    menu_main
}
