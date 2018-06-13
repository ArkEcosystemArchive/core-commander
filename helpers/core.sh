#!/usr/bin/env bash

core_required ()
{
    if [[ ! -d "$CORE_DIR" ]]; then
        error "ARK Core needs to be installed for this action!"

        press_to_continue

        menu_main
    fi
}

core_not_required ()
{
    if [[ -d "$CORE_DIR" ]]; then
        error "ARK Core needs to be NOT installed for this action!"

        press_to_continue

        menu_main
    fi
}
