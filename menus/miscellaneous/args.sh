#!/usr/bin/env bash

menu_miscellaneous_parse_args ()
{
    local choice

    read -p "$(text_blue "    Please enter your choice: ")" choice

    case "$choice" in
        u|U)
            miscellaneous_install_updates

            press_to_continue

            menu_miscellaneous
        ;;
        e|E)
            miscellaneous_commander_executable

            press_to_continue

            menu_miscellaneous
        ;;
        a|A)
            miscellaneous_commander_alias

            press_to_continue

            menu_miscellaneous
        ;;
        h|H)
            menu_miscellaneous_help
        ;;
        x|X)
            menu_main
        ;;
        *)
            echo -e "$(text_yellow "    Invalid option chosen, please select a valid option and try again.")"
            wait_to_continue
            menu_miscellaneous
        ;;
    esac
}
