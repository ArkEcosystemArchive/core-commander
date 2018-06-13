#!/usr/bin/env bash

process_vars ()
{
    local process_postgres=$(pgrep -a postgres | awk '{print $1}')

    if [[ -z "$process_postgres" ]]; then
        sudo service postgresql start
    fi
}
