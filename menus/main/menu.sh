#!/usr/bin/env bash

menu_main ()
{
    refresh_state

    if [[ "$STATUS_RELAY" = "On" ]]; then
        local relay="$(text_white "Relay:")  $(text_green ${STATUS_RELAY})"
    else
        local relay="$(text_white "Relay:") $(text_red ${STATUS_RELAY})"
    fi

    if [[ "$STATUS_FORGER" = "On" ]]; then
        local forger="$(text_white "Forger:")  $(text_green ${STATUS_FORGER})"
    else
        local forger="$(text_white "Forger:") $(text_red ${STATUS_FORGER})"
    fi

    if [[ "$STATUS_NTP" = "On" ]]; then
        local ntp="$(text_white "NTP:")  $(text_green ${STATUS_NTP})"
    else
        local ntp="$(text_white "NTP:") $(text_red ${STATUS_NTP})"
    fi

    if [[ "$STATUS_PGSQL" = "On" ]]; then
        local pgsql="$(text_white "PG:")  $(text_green ${STATUS_PGSQL})"
    else
        local pgsql="$(text_white "PG:") $(text_red ${STATUS_PGSQL})"
    fi

    if [[ -d "$CORE_DIR" ]]; then
        if [[ "$STATUS_CORE_UPDATE" = "Yes" ]]; then
            local core_update="Update: $(text_yellow ${STATUS_CORE_UPDATE})"
        else
            local core_update="Update: $(text_green ${STATUS_CORE_UPDATE})"
        fi
    fi

    local core_version_raw="Core: ${VERSION_CORE}"
    local node_version_raw="Node: ${VERSION_NODE}"
    local pg_version_raw="PG: ${VERSION_PSQL}"

    local core_version="$(text_white "Core:") $(text_blue ${VERSION_CORE})"
    local node_version="$(text_white "NodeJS:") $(text_blue ${VERSION_NODE})"
    local pg_version="$(text_white "PG:") $(text_blue ${VERSION_PSQL})"

    local pad=$(printf '%0.1s' " "{1..30})
    local whitespace=$((61 - ${#core_version_raw} - ${#node_version_raw} - ${#pg_version_raw}))
    local padding=$(($whitespace / 2))

    trap - INT

    ascii

    printf '    %s' "$core_version"
    printf '%*.*s' 0 $(($padding)) "$pad"
    printf '%s' "$node_version"
    if [ $((whitespace % 2)) -eq 1 ]; then
        padding=$(($padding + 1))
    fi
    printf '%*.*s' 0 $(($padding)) "$pad"
    printf '%s\n' "$pg_version"

    divider

    echo "    $relay         $forger         $ntp         $pgsql"

    divider

    if [[ -d "$CORE_DIR" ]]; then
        text_white "    A. Manage ARK Core"
        text_white "    R. Manage Relay"
        text_white "    F. Manage Forger"
        text_white "    E. Manage Explorer"
    else
        text_white "    I. Install ARK Core"

        divider
    fi

    text_white "    C. Manage Commander"

    divider

    text_white "    M. Miscellaneous"

    divider

    if [[ -d "$CORE_DIR" ]]; then
        text_white "    L. Show Log"
        text_white "    P. Show Process Monitor"

        divider
    fi

    text_white "    H. Show Help"

    divider

    text_white "    X. Exit"

    divider

    menu_main_parse_args
}
