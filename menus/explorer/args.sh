#!/usr/bin/env bash

menu_manage_explorer_parse_args ()
{
    local choice

    read -p "$(text_blue "    Please enter your choice: ")" choice

    case "$choice" in
        i|I)
            explorer_install

            press_to_continue

            menu_manage_explorer
        ;;
        u|U)
            explorer_update

            press_to_continue

            menu_manage_explorer
        ;;
        p|P)
            explorer_uninstall

            press_to_continue

            menu_manage_explorer
        ;;
        s|S)
            explorer_start

            press_to_continue

            menu_manage_explorer
        ;;
        k|K)
            explorer_stop

            press_to_continue

            menu_manage_explorer
        ;;
        r|R)
            explorer_restart

            press_to_continue

            menu_manage_explorer
        ;;
        l|L)
            explorer_logs

            press_to_continue

            menu_manage_explorer
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
