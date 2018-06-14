#!/usr/bin/env bash

menu_manage_explorer_help ()
{
    ascii

    text_yellow "    Install ARK Explorer (I)"
    text_white "    installs the ARK blockchain explorer on your server."
    echo

    text_yellow "    Start ARK Explorer (S)"
    text_white "    starts the ARK blockchain explorer process (only visible if you have ARK explorer installed)."
    echo

    text_yellow "    Show Log (L)"
    text_white "    shows the PM2 explorer process log."
    echo

    text_yellow "    Show Help (H)"
    text_white "    opens the help file where all this information is available."

    divider

    text_blue "    For more information head over to https://arkdocs.readme.io/"
    echo

    press_to_continue

    menu_main
}
