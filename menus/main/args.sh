#!/usr/bin/env bash

menu_main_parse_args ()
{
    local choice

    read -p "$(text_blue "    Please enter your choice: ")" choice

    case "$choice" in
        i|I)
            core_install

            press_to_continue

            menu_main
        ;;
        a|A)
            menu_manage_core
        ;;
        r|R)
            menu_manage_relay
        ;;
        f|F)
            menu_manage_forger
        ;;
        e|E)
            menu_manage_explorer
        ;;
        c|C)
            menu_manage_commander
        ;;
        m|M)
            menu_miscellaneous
        ;;
        p|P)
            process_monitor
        ;;
        l|L)
            utils_log

            if [[ $? -eq 130 ]]; then
                press_to_continue
            else
                wait_to_continue
            fi
        ;;
        h|H)
            menu_main_help
        ;;
        x|X)
            exit 0
        ;;
        *)
            echo -e "$(text_yellow "    Invalid option chosen, please select a valid option and try again.")"
            wait_to_continue
            menu_main
        ;;
    esac
}
