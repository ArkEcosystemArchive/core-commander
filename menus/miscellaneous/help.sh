#!/usr/bin/env bash

menu_miscellaneous_help ()
{
    ascii

    text_yellow "    Install OS Updates (U)"
    text_white "    checks for OS updates and installs them if available."
    echo

    text_yellow "    Create Commander Executable (E)"
    text_white "    lets you create an executable so you can do “./commander.sh” instead of “bash ./commander.sh” to start the Commander."
    echo

    text_yellow "    Create Commander Alias (A)"
    text_white "    lets you create an alias so you can start Commander by inputting “commander” instead of “bash ./commander.sh”."
    echo

    text_yellow "    Show Help (H)"
    text_white "    opens the help file where all this information is available."

    divider

    text_blue "    For more information head on over to https://docs.ark.io/"
    echo

    press_to_continue

    menu_main
}
