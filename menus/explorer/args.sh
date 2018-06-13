#!/usr/bin/env bash

menu_manage_explorer_parse_args ()
{
    local choice

    read -p "$(text_blue "    Please enter your choice: ")" choice

    case "$choice" in
        i|I)
            explorer_install

            press_to_continue
        ;;
        u|U)
            explorer_update

            press_to_continue
        ;;
        p|P)
            explorer_uninstall

            press_to_continue
        ;;
        s|S)
            explorer_start

            press_to_continue
        ;;
        k|K)
            explorer_stop

            press_to_continue
        ;;
        r|R)
            explorer_restart

            press_to_continue
        ;;
        l|L)
            explorer_logs

            press_to_continue
        ;;
        h|H)
            menu_manage_explorer_help
        ;;
        x|X)
            menu_main
        ;;
        *)
            echo -e "$(text_yellow "    Invalid option chosen, please select a valid option and try again.")"
            wait_to_continue
            menu_manage_explorer
        ;;
    esac
}
