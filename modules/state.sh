#!/usr/bin/env bash

refresh_state ()
{
    get_versions

    ntp_status
    pgsql_status
    relay_status
    forger_status
    explorer_status
}
