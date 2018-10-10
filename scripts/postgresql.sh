#!/usr/bin/env bash

pgsql_start ()
{
    heading "Starting PostgreSQL..."

    sudo systemctl start postgresql >> "$commander_log" 2>&1

    pgsql_status

    success "Started PostgreSQL!"
}

pgsql_stop ()
{
    heading "Stopping PostgreSQL..."

    sudo systemctl stop postgresql >> "$commander_log" 2>&1

    pgsql_status

    success "Stopped PostgreSQL!"
}

pgsql_restart ()
{
    heading "Restarting PostgreSQL..."

    sudo systemctl restart postgresql >> "$commander_log" 2>&1

    pgsql_status

    success "Restarted PostgreSQL!"
}

pgsql_install ()
{
    heading "Installing PostgreSQL..."

    sudo apt-get update >> "$commander_log" 2>&1
    sudo apt-get install postgresql postgresql-contrib -y | tee -a "$commander_log"

    pgsql_start

    success "Installed PostgreSQL!"
}

pgsql_status ()
{
    local status=$(pgrep -x postgres)

    if [[ -z "$status" ]]; then
        STATUS_PGSQL="Off"
    else
        STATUS_PGSQL="On"
    fi
}
