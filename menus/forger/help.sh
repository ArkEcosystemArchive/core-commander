#!/usr/bin/env bash

menu_manage_forger_help ()
{
    ascii

    text_yellow "    Stop Forger (K)"
    text_white "    stops the ARK relay node process (shown only if the forger node is running)."
    echo

    text_yellow "    Start Forger (S)"
    text_white "    starts the ARK forger node process (shown only if the forger node is not running)."
    echo

    text_yellow "    Restart Forger (R)"
    text_white "    restarts (stops and then starts) the forger node process."
    echo

    text_yellow "    Configure Forger (C)"
    text_white "    lets you configure the forger config file (optional: use BIP38 encryption and set your delegate secret)."
    echo

    text_yellow "    Show Logs (L)"
    text_white "    shows the PM2 forger node process logs (shown only if the forger node is running)."
    echo

    text_yellow "    Show Help (H)"
    text_white "    opens the help file where all this information is available."

    divider

    text_blue "    For more information head on over to https://docs.ark.io/"
    echo

    press_to_continue

    menu_main
}
