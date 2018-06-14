#!/usr/bin/env bash

menu_main_help ()
{
    ascii

    text_yellow "    Install ARK Core (I)"
    text_white "    starts the ARK core intall process."
    echo

    text_yellow "    Manage ARK Core (A)"
    text_white "    opens the ARK core options."
    echo

    text_yellow "    Manage Relay (R)"
    text_white "    opens the ARK relay node process options."
    echo

    text_yellow "    Manage Forger (F)"
    text_white "    opens the ARK forger node process options."
    echo

    text_yellow "    Manage Explorer (E)"
    text_white "    opens the ARK explorer options."
    echo

    text_yellow "    Manage Commander (C)"
    text_white "    opens the ARK commander options."
    echo

    text_yellow "    Miscellaneous (M)"
    text_white "    opens the miscellaneous menu."
    echo

    text_yellow "    Show Logs (L)"
    text_white "    opens the Ark core logs so you can see what is going on with your node process in real-time."
    echo

    text_yellow "    Show Process Monitor (P)"
    text_white "    opens the PM2 monitor tool so you can see log information where the app is running, CPU, memory usage and much more."
    echo

    text_yellow "    Show Help (H)"
    text_white "    opens the help file where all this information is available."
    echo

    text_yellow "    X — Exit"
    text_white "    exits ARK Commander"

    divider

    text_blue "    For more information head on over to https://docs.ark.io/"
    echo

    press_to_continue

    menu_main
}
