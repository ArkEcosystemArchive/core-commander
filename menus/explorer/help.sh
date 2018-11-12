#!/usr/bin/env bash

menu_manage_explorer_help ()
{
    ascii

    text_yellow "    Install Ark Explorer (I)"
    text_white "    installs Ark Explorer on your server."
    echo

    text_yellow "    Stop Ark Explorer (K)"
    text_white "    stops the Ark Explorer process (shown only if the Ark Explorer process is running)."
    echo

    text_yellow "    Start Ark Explorer (S)"
    text_white "    starts the Ark Explorer process (shown only if Ark Explorer is installed)."
    echo

    text_yellow "    Restart Ark Explorer (R)"
    text_white "    restarts (stops and then starts) the Ark Explorer process (shown only if Ark Explorer is installed and running)."
    echo

    text_yellow "    Update Ark Explorer (U)"
    text_white "    updates Ark Explorer if a new version is available (shown only if Ark Explorer is installed)."
    echo

    text_yellow "    Uninstall Ark Explorer (P)"
    text_white "    uninstalls Ark Explorer from your system (shown only if Ark Explorer is installed)."
    echo

    text_yellow "    Show Log (L)"
    text_white "    shows the PM2 explorer process log."
    echo

    text_yellow "    Show Help (H)"
    text_white "    opens the help file where all this information is available."

    divider

    text_blue "    For more information head over to https://docs.ark.io/"
    echo

    press_to_continue

    menu_main
}
