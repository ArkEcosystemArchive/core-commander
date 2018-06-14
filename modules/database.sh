#!/usr/bin/env bash

database_drop_user ()
{
    heading "Dropping Database User..."
    sudo -u postgres dropuser --if-exists "$USER" >> "$commander_log" 2>&1
    success "Dropped Database User!"
}

database_destroy ()
{
    heading "Destroying Database..."
    sudo -u postgres dropdb --if-exists "ark_${CORE_NETWORK}" >> "$commander_log" 2>&1
    success "Destroyed Database!"
}

database_create ()
{
    heading "Creating Database..."
    wait_to_continue
    sudo -u postgres psql -c "CREATE USER $USER WITH PASSWORD 'password' CREATEDB;" >> "$commander_log" 2>&1
    wait_to_continue
    createdb "ark_${CORE_NETWORK}"
    success "Created Database!"
}

database_close ()
{
    heading "Closing Database..."
    sudo -u postgres psql -c "UPDATE pg_database SET datallowconn = false WHERE datname = 'ark_${CORE_NETWORK}';" >> "$commander_log" 2>&1
    sudo -u postgres psql -c "SELECT pid, pg_terminate_backend(pid) FROM pg_stat_activity WHERE datname = 'ark_${CORE_NETWORK}' AND pid <> pg_backend_pid();" >> "$commander_log" 2>&1
    success "Closed Database!"
}
