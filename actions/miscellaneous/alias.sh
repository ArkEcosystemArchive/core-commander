#!/usr/bin/env bash

miscellaneous_commander_alias()
{
    heading "Installing alias..."

    echo "alias commander='bash ${commander_dir}/commander.sh'" | tee -a "${HOME}/.bashrc"
    . "${HOME}/.bashrc"

    warning "If the \"commander\" command does not work after you close ARK Core Commander, manually execute \"source ${HOME}/.bashrc\"."

    success "Installation complete!"
}
