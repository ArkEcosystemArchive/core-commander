#!/usr/bin/env bash

get_versions ()
{
    if [[ -d "$CORE_DIR" ]]; then
        cd "$CORE_DIR"
        VERSION_CORE=$(git rev-parse --short HEAD)
    else
        VERSION_CORE="n/a"
    fi

    if [[ -x "$(command -v node)" ]]; then
        VERSION_NODE=$(node -v | sed 's/v//g')
    else
        VERSION_NODE="n/a"
    fi

    if [[ -x "$(command -v npm)" ]]; then
        VERSION_NPM=$(npm -v)
    else
        VERSION_NPM="n/a"
    fi

    if [[ -x "$(command -v yarn)" ]]; then
        VERSION_YARN=$(yarn -v)
    else
        VERSION_YARN="n/a"
    fi

    if [[ -x "$(command -v psql)" ]]; then
        VERSION_PSQL=$(psql -V | awk '{ print $3 }')
    else
        VERSION_PSQL="n/a"
    fi

    if [[ -x "$(command -v redis-server)" ]]; then
        VERSION_REDIS=$(redis-server -v | awk '{ print $3 }' | sed 's/v=//g')
    else
        VERSION_REDIS="n/a"
    fi
}
