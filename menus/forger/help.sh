#!/usr/bin/env bash

menu_manage_forger_help ()
{
    ascii

    text_yellow "    Stop Forger (K)"
    text_white "    stops ARK forger node process (shown only if forger node is running)."
    echo

    text_yellow "    Start Forger (S)"
    text_white "    starts ARK forger node process (shown only if forger node is not running)."
    echo

    text_yellow "    Restart Forger (R)"
    text_white "    restarts (stops and starts) forger node process."
    echo

    text_yellow "    Configure Forger (C)"
    text_white "    lets you configure forger config file (optional BIP38 encryption and your delegate secret)."
    echo

    text_yellow "    Show Log (L)"
    text_white "    shows PM2 forger node process log (shown only if forger node is not running)."
    echo

    text_yellow "    Show Help (H)"
    text_white "    opens help file where all this information is available."

    divider

    text_blue "    For more information head over to https://arkdocs.readme.io/"
    echo

    press_to_continue

    menu_main
}
