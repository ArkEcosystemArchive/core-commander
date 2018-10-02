#!/usr/bin/env bash

database_drop_user ()
{
    heading "Dropping Database User..."

    sudo -u postgres dropuser --if-exists "$ARK_DB_USERNAME" | tee -a "$commander_log"

    success "Dropped Database User!"
}

database_destroy ()
{
    heading "Destroying Database..."

    sudo -u postgres dropdb --if-exists "$ARK_DB_DATABASE" | tee -a "$commander_log"

    success "Destroyed Database!"
}

database_create ()
{
    heading "Creating Database..."

    wait_to_continue

    # needed to avoid "could not connect to database template1" errors
    sudo -u postgres psql -c "CREATE USER $USER WITH PASSWORD 'password' CREATEDB;" | tee -a "$commander_log"

    sudo -u postgres psql -c "CREATE USER $ARK_DB_USERNAME WITH PASSWORD '$ARK_DB_PASSWORD' CREATEDB;" | tee -a "$commander_log"

    sudo -u postgres createdb "$ARK_DB_DATABASE" | tee -a "$commander_log"

    sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE $ARK_DB_DATABASE TO $ARK_DB_USERNAME;" | tee -a "$commander_log"

    wait_to_continue

    success "Created Database!"
}
