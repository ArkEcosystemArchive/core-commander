#!/usr/bin/env bash

check_for_modifications ()
{
    local search="github.com"
    local replace="raw.githubusercontent.com"
    local host="${CORE_REPO/$search/$replace}"
    
    cd "$CORE_DIR"
    local branch=$(git symbolic-ref --short -q HEAD)

    local local_checksum=$(sha256sum "${CORE_DIR}/$1" | awk '{ print $1 }')
    local remote_checksum=$(curl -s "${host}/${branch}/$1" | sha256sum | awk '{ print $1 }')

    if [[ "$local_checksum" != "$remote_checksum" ]]; then
        read -p "$1 has been modified in the latest update, do you want to replace $2? THIS WILL OVERWRITE ANY MODIFICATIONS! [Y/n] : " choice

        if [[ -z "$choice" || "$choice" =~ ^(yes|y|Y) ]]; then
            cp -f "${CORE_DIR}/$1" "$2"
        fi
    fi
}
