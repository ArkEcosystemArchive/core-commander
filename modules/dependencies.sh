#!/usr/bin/env bash

DEPENDENCIES_PROGRAMS=("build-essential libcairo2-dev pkg-config libtool autoconf automake python git curl libpq-dev jq")
DEPENDENCIES_NODEJS=("pm2")

apt_package_installed()
{
    local package="$1"
    local install_status

    install_status=$(dpkg --list "$package" 2>>"$commander_log" | tail -n 1 | head -c 3) || true

    # interpretation of the 3 characters of install status
    # https://linuxprograms.wordpress.com/2010/05/11/status-dpkg-list/
    if [[ "$install_status" == "ii " ]]; then
        return 0
    else
        return 1
    fi
}

install_base_dependencies ()
{
    heading "Installing system dependencies..."

    sudo apt-get update >> "$commander_log" 2>&1
    sudo apt-get install -y git curl apt-transport-https update-notifier | tee -a "$commander_log"

    nodejs_install

    yarn_install

    success "Installed system dependencies!"
}

install_program_dependencies ()
{
    heading "Installing program dependencies..."

    TO_INSTALL=""
    for dependency in ${DEPENDENCIES_PROGRAMS[@]}; do
        if ! apt_package_installed "$dependency" ; then
            TO_INSTALL="${TO_INSTALL}${dependency} "
        fi
    done

    if [[ ! -z "$TO_INSTALL" ]]; then
        warning "Dependencies [${TO_INSTALL}] are not installed."

        heading "Installing program dependencies..."

        sudo sh -c "sudo apt-get install $TO_INSTALL -y" | tee -a "$commander_log"

        success "Program dependencies Installed!"
    fi

    pgsql_install
    ntp_install

    success "Installed program dependencies!"
}

install_nodejs_dependencies ()
{
    heading "Installing node.js dependencies..."

    TO_INSTALL=""
    for dependency in ${DEPENDENCIES_NODEJS[@]}; do
        INSTALLED=$(npm list -g "$dependency" | fgrep "$dependency" | awk '{print $2}' | awk -F'@' '{print $1}') || true

        if [[ "$INSTALLED" != "$dependency" ]]; then
            TO_INSTALL="${TO_INSTALL}${dependency} "
        fi
    done

    if [[ ! -z "$TO_INSTALL" ]]; then
        warning "[${TO_INSTALL}] are not installed."

        heading "Installing node.js dependencies..."

        sh -c "sudo npm install -g $TO_INSTALL" | tee -a "$commander_log"

        success "Installed node.js dependencies!"
    fi

    if [[ ! -d "${commander_dir}/node_modules/dotenv" ]]; then
      sh -c "npm install dotenv"
    fi

    pm2_install
}

install_system_updates ()
{
    heading "Installing system updates..."

    sudo apt-get update >> "$commander_log" 2>&1
    sudo apt-get upgrade -yqq | tee -a "$commander_log"
    sudo apt-get dist-upgrade -yq | tee -a "$commander_log"
    sudo apt-get autoremove -yyq | tee -a "$commander_log"
    sudo apt-get autoclean -yq | tee -a "$commander_log"

    success "Installed system updates!"
}
