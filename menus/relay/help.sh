#!/usr/bin/env bash

menu_manage_relay_help ()
{
    ascii

    divider

    text_yellow "    Stop Relay (K)"
    text_white "    stops ARK relay node process (shown only if relay node is running)."
    echo

    text_yellow "    Start Relay (S)"
    text_white "    starts ARK relay node process (shown only if relay node is not running)."
    echo

    text_yellow "    Restart Relay (R)"
    text_white "    restarts (stops and starts) relay node process."
    echo

    text_yellow "    Show Log (L)"
    text_white "    shows PM2 relay node process log."
    echo

    text_yellow "    Show Help (H)"
    text_white "    opens help file where all this information is available."

    divider

    text_blue "    For more information head over to https://arkdocs.readme.io/"
    echo

    press_to_continue

    menu_main
}
