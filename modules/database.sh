#!/usr/bin/env bash

database_drop_user ()
{
    heading "Dropping Database User..."

    sudo -u postgres dropuser --if-exists "$ARK_DB_PASSWORD" >> "$commander_log" 2>&1

    success "Dropped Database User!"
}

database_destroy ()
{
    heading "Destroying Database..."

    sudo -u postgres dropdb --if-exists "$ARK_DB_DATABASE" >> "$commander_log" 2>&1

    success "Destroyed Database!"
}

database_create ()
{
    heading "Creating Database..."

    wait_to_continue

    # needed to avoid "could not connect to database template1" errors
    sudo -u postgres psql -c "CREATE USER $USER WITH PASSWORD 'password' CREATEDB;" >> "$commander_log" 2>&1

    sudo -u postgres psql -c "CREATE USER $ARK_DB_USERNAME WITH PASSWORD '$ARK_DB_PASSWORD' CREATEDB;" >> "$commander_log" 2>&1
    sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE $ARK_DB_DATABASE TO $ARK_DB_USERNAME;" >> "$commander_log" 2>&1

    wait_to_continue

    createdb "$ARK_DB_DATABASE" >> "$commander_log" 2>&1

    success "Created Database!"
}
