#!/usr/bin/env bash

menu_manage_relay_parse_args ()
{
    local choice

    read -p "$(text_blue "    Please enter your choice: ")" choice

    case "$choice" in
        s|S)
            relay_start

            press_to_continue

            menu_manage_relay
        ;;
        k|K)
            relay_stop

            press_to_continue

            menu_manage_relay
        ;;
        r|R)
            relay_restart

            press_to_continue

            menu_manage_relay
        ;;
        l|L)
            relay_logs

            press_to_continue

            menu_manage_relay
        ;;
        h|H)
            menu_manage_relay_help
        ;;
        x|X)
            menu_main
        ;;
        *)
            echo -e "$(text_yellow "    Invalid option chosen, please select a valid option and try again.")"
            wait_to_continue
            menu_manage_relay
        ;;
    esac
}
