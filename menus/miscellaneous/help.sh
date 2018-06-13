#!/usr/bin/env bash

menu_miscellaneous_help ()
{
    ascii

    text_yellow "    Install OS Updates (U)"
    text_white "    checks for OS updates and installs them if available."
    echo

    text_yellow "    Create Commander Executable (E)"
    text_white "    lets you create executable so you can do “./commander.sh” instead of “bash ./commander.sh” to start commander."
    echo

    text_yellow "    Create Commander Alias (A)"
    text_white "    lets you create alias so you can start Commander by inputting “commander” instead of “bash ./commander.sh”."
    echo

    text_yellow "    Show Help (H)"
    text_white "    opens help file where all this information is available."

    divider

    text_blue "    For more information head over to https://arkdocs.readme.io/"
    echo

    press_to_continue

    menu_main
}
