#!/usr/bin/env bash

nodejs_install ()
{
    heading "Installing node.js & npm..."

    sudo rm -rf /usr/local/{lib/node{,/.npm,_modules},bin,share/man}/{npm*,node*,man1/node*}
    sudo rm -rf ~/{.npm,.forever,.node*,.cache,.nvm}

    sudo wget --quiet -O - https://deb.nodesource.com/gpgkey/nodesource.gpg.key | sudo apt-key add -
    (echo "deb https://deb.nodesource.com/node_10.x $(lsb_release -s -c) main" | sudo tee /etc/apt/sources.list.d/nodesource.list) | tee -a "$commander_log"
    sudo apt-get update >> "$commander_log" 2>&1
    sudo apt-get install nodejs -y | tee -a "$commander_log"

    success "Installed node.js & npm!"
}
