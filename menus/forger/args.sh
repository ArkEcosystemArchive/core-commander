#!/usr/bin/env bash

menu_manage_forger_parse_args ()
{
    local choice

    read -p "$(text_blue "    Please enter your choice: ")" choice

    case "$choice" in
        s|S)
            forger_start

            press_to_continue
        ;;
        k|K)
            forger_stop

            press_to_continue
        ;;
        r|R)
            forger_restart

            press_to_continue
        ;;
        c|C)
            forger_configure

            press_to_continue
        ;;
        l|L)
            forger_logs

            press_to_continue
        ;;
        h|H)
            forger_help
        ;;
        x|X)
            menu_manage_forger_help
        ;;
        *)
            echo -e "$(text_yellow "    Invalid option chosen, please select a valid option and try again.")"
            wait_to_continue
            menu_manage_forger
        ;;
    esac
}
