#!/usr/bin/env bash

nodejs_install ()
{
    heading "Installing node.js & npm..."

    sudo rm -rf /usr/local/{lib/node{,/.npm,_modules},bin,share/man}/{npm*,node*,man1/node*}
    sudo rm -rf ~/{.npm,.forever,.node*,.cache,.nvm}

    (echo "deb https://deb.nodesource.com/node_9.x $(lsb_release -s -c) main" | sudo tee /etc/apt/sources.list.d/nodesource.list) >> "$commander_log" 2>&1
    sudo apt-get update >> "$commander_log" 2>&1
    sudo apt-get install nodejs -y --allow-unauthenticated >> "$commander_log" 2>&1

    success "Installed node.js & npm!"
}
