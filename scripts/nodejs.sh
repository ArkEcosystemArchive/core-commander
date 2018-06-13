#!/usr/bin/env bash

nodejs_install ()
{
    heading "Installing node.js & npm..."

    (curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash) >> "$commander_log" 2>&1

    export NVM_DIR="${HOME}/.nvm"
    [ -s "${NVM_DIR}/nvm.sh" ] && . "${NVM_DIR}/nvm.sh"

    nvm install 9.11.1 >> "$commander_log" 2>&1
    nvm use 9.11.1 >> "$commander_log" 2>&1
    nvm alias default 9.11.1 >> "$commander_log" 2>&1

    success "Installed node.js & npm!"
}
