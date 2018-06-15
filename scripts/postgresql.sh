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

    sudo wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
    (sudo add-apt-repository "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -s -c)-pgdg main") | tee -a "$commander_log"

    sudo apt-get update | tee -a "$commander_log"
    sudo apt-get install -y postgresql-10 | tee -a "$commander_log"

    pgsql_start

    success "Installed PostgreSQL!"
}

pgsql_status ()
{
    local status=$(sudo pgrep -x postgres)

    if [[ -z "$status" ]]; then
        STATUS_PGSQL="Off"
    else
        STATUS_PGSQL="On"
    fi
}
