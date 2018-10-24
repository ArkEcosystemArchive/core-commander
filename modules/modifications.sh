#!/usr/bin/env bash

check_for_modifications ()
{
    local_checksum=$(sha256sum "$1" | awk '{ print $1 }')
    remote_checksum=$(sha256sum "$2" | awk '{ print $1 }')

    if [[ "$local_checksum" != "$remote_checksum" ]]; then
        read -p "$1 has been modified in the latest update, do you want to replace it? THIS WILL REMOVE ANY MODIFICATIONS! [Y/n] : " choice

        if [[ -z "$choice" || "$choice" =~ ^(yes|y|Y) ]]; then
            cp -f "$2" "$1"
        fi
    fi
}
