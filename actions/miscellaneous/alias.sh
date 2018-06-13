#!/usr/bin/env bash

miscellaneous_commander_alias()
{
    heading "Installing alias..."

    echo "alias commander='bash ${commander_dir}/commander.sh'" | tee -a "${HOME}/.bashrc"
    . "${HOME}/.bashrc"

    success "Installation complete!"
}
