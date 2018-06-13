#!/usr/bin/env bash

menu_manage_commander_parse_args ()
{
    local choice

    read -p "$(text_blue "    Please enter your choice: ")" choice

    case "$choice" in
        r|R)
            commander_configure_repo

            press_to_continue
        ;;
        a|A)
            commander_configure_core_directory

            press_to_continue
        ;;
        d|D)
            commander_configure_data_directory

            press_to_continue
        ;;
        c|C)
            commander_configure_config_directory

            press_to_continue
        ;;
        t|T)
            commander_configure_token

            press_to_continue
        ;;
        n|N)
            commander_configure_token_network

            press_to_continue
        ;;
        s|S)
            commander_configure_explorer_repo

            press_to_continue
        ;;
        e|E)
            commander_configure_explorer_directory

            press_to_continue
        ;;
        h|H)
            menu_manage_commander_help
        ;;
        x|X)
            menu_main
        ;;
        *)
            echo -e "$(text_yellow "    Invalid option chosen, please select a valid option and try again.")"
            wait_to_continue
            menu_manage_commander
        ;;
    esac
}
