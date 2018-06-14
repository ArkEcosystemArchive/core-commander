#!/usr/bin/env bash

menu_manage_relay_help ()
{
    ascii

    divider

    text_yellow "    Stop Relay (K)"
    text_white "    stops the ARK relay node process (shown only if the relay node is running)."
    echo

    text_yellow "    Start Relay (S)"
    text_white "    starts the ARK relay node process (shown only if the relay node is not running)."
    echo

    text_yellow "    Restart Relay (R)"
    text_white "    restarts (stops and then starts) the relay node process."
    echo

    text_yellow "    Show Logs (L)"
    text_white "    shows the PM2 relay node process logs."
    echo

    text_yellow "    Show Help (H)"
    text_white "    opens the help file where all this information is available."

    divider

    text_blue "    For more information head on over to https://docs.ark.io/"
    echo

    press_to_continue

    menu_main
}
