#!/usr/bin/env bash

miscellaneous_commander_executable()
{
    heading "Making Commander executable..."

    chmod +x "${commander_dir}/commander.sh"

    success "Operation complete!"
}
