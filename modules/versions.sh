#!/usr/bin/env bash

get_versions ()
{
    core_version
    node_version
    npm_version
    yarn_version
    psql_version
}

core_version ()
{
    if [[ -d "$CORE_DIR" ]]; then
        cd "$CORE_DIR"
        VERSION_CORE=$(git rev-parse --short=8 HEAD)
    else
        VERSION_CORE="n/a"
    fi
}

node_version ()
{
    if [[ -x "$(command -v node)" ]]; then
        VERSION_NODE=$(node -v | sed 's/v//g')
    else
        VERSION_NODE="n/a"
    fi
}

npm_version ()
{
    if [[ -x "$(command -v npm)" ]]; then
        VERSION_NPM=$(npm -v)
    else
        VERSION_NPM="n/a"
    fi
}

yarn_version ()
{
    if [[ -x "$(command -v yarn)" ]]; then
        VERSION_YARN=$(yarn -v)
    else
        VERSION_YARN="n/a"
    fi
}

psql_version ()
{
    if [[ -x "$(command -v psql)" ]]; then
        VERSION_PSQL=$(psql -V | awk '{ print $3 }')
    else
        VERSION_PSQL="n/a"
    fi
}
