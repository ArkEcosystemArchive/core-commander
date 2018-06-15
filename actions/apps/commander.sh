#!/usr/bin/env bash

commander_configure_repo ()
{
    info "Current: $CORE_REPO"
    read -p "Please enter the core repository you would like to use: " choice

    if [[ -z "$choice" ]]; then
        error "You have entered an empty value. Please try again."

        return
    fi

    __commander_configure "$choice" "$CORE_DIR" "$CORE_DATA" "$CORE_CONFIG" "$CORE_TOKEN" "$CORE_NETWORK" "$EXPLORER_REPO" "$EXPLORER_DIR"

    if [[ -d "$CORE_DIR" ]]; then
        warning "ARK Core will be pointed to ${CORE_REPO}. This will restart your node."

        press_to_continue

        relay_stop

        cd "$CORE_DIR"
        git reset --hard | tee -a "$commander_log"
        git remote set-url origin "$CORE_REPO" | tee -a "$commander_log"
        git pull | tee -a "$commander_log"

        relay_start
    fi
}

commander_configure_core_directory ()
{
    local current="$CORE_DIR"

    info "Current: $CORE_DIR"
    read -p "Please enter the core directory you would like to use: " choice

    if [[ -z "$choice" ]]; then
        error "You have entered an empty value. Please try again."

        return
    fi

    __commander_configure "$CORE_REPO" "$choice" "$CORE_DATA" "$CORE_CONFIG" "$CORE_TOKEN" "$CORE_NETWORK" "$EXPLORER_REPO" "$EXPLORER_DIR"

    if [[ -d "$CORE_DIR" ]]; then
        warning "ARK Core will be stopped and moved to ${CORE_DIR}. This will restart your node."

        press_to_continue

        forger_stop
        relay_stop

        mv "$current" "$CORE_DIR"

        relay_start
    fi
}

commander_configure_data_directory ()
{
    info "Current: $CORE_DATA"
    read -p "Please enter the core data directory you would like to use: " choice

    if [[ -z "$choice" ]]; then
        error "You have entered an empty value. Please try again."

        return
    fi

    __commander_configure "$CORE_REPO" "$CORE_DIR" "$choice" "$CORE_CONFIG" "$CORE_TOKEN" "$CORE_NETWORK" "$EXPLORER_REPO" "$EXPLORER_DIR"
}

commander_configure_config_directory ()
{
    info "Current: $CORE_CONFIG"
    read -p "Please enter the core config directory you would like to use: " choice

    if [[ -z "$choice" ]]; then
        error "You have entered an empty value. Please try again."

        return
    fi

    __commander_configure "$CORE_REPO" "$CORE_DIR" "$CORE_DATA" "$choice" "$CORE_TOKEN" "$CORE_NETWORK" "$EXPLORER_REPO" "$EXPLORER_DIR"
}

commander_configure_token ()
{
    info "Current: $CORE_TOKEN"
    read -p "Please enter the token you would like to use: " choice

    if [[ -z "$choice" ]]; then
        error "You have entered an empty value. Please try again."

        return
    fi

    __commander_configure "$CORE_REPO" "$CORE_DIR" "$CORE_DATA" "$CORE_CONFIG" "$choice" "$CORE_NETWORK" "$EXPLORER_REPO" "$EXPLORER_DIR"
}

commander_configure_token_network ()
{
    info "Current: $CORE_NETWORK"
    read -p "Please enter the network you would like to use: " choice

    if [[ -z "$choice" ]]; then
        error "You have entered an empty value. Please try again."

        return
    fi

    __commander_configure "$CORE_REPO" "$CORE_DIR" "$CORE_DATA" "$CORE_CONFIG" "$CORE_TOKEN" "$choice" "$EXPLORER_REPO" "$EXPLORER_DIR"
}

commander_configure_explorer_repo ()
{
    info "Current: $EXPLORER_REPO"
    read -p "Please enter the explorer repository you would like to use: " choice

    if [[ -z "$choice" ]]; then
        error "You have entered an empty value. Please try again."

        return
    fi

    __commander_configure "$CORE_REPO" "$CORE_DIR" "$CORE_DATA" "$CORE_CONFIG" "$CORE_TOKEN" "$CORE_NETWORK" "$choice" "$EXPLORER_DIR"

    if [[ -d "$EXPLORER_DIR" ]]; then
        warning "ARK Explorer will be pointed to ${EXPLORER_REPO}. This will restart your explorer."

        press_to_continue

        explorer_stop

        cd "$EXPLORER_DIR"
        git reset --hard | tee -a "$commander_log"
        git remote set-url origin "$EXPLORER_REPO" | tee -a "$commander_log"
        git pull | tee -a "$commander_log"

        explorer_start
    fi
}

commander_configure_explorer_directory ()
{
    local current="$EXPLORER_DIR"

    info "Current: $EXPLORER_DIR"
    read -p "Please enter the explorer directory you would like to use: " choice

    if [[ -z "$choice" ]]; then
        error "You have entered an empty value. Please try again."

        return
    fi

    __commander_configure "$CORE_REPO" "$CORE_DIR" "$CORE_DATA" "$CORE_CONFIG" "$CORE_TOKEN" "$CORE_NETWORK" "$EXPLORER_REPO" "$choice"

    if [[ -d "$EXPLORER_DIR" ]]; then
        warning "ARK Explorer will be stopped and moved to ${EXPLORER_DIR}. This will restart your explorer."

        press_to_continue

        explorer_stop

        mv "$current" "$EXPLORER_DIR"

        explorer_start
    fi
}

__commander_configure ()
{
    rm "$commander_config"
    touch "$commander_config"

    echo "CORE_REPO=$1" >> "$commander_config" 2>&1
    echo "CORE_DIR=$2" >> "$commander_config" 2>&1
    echo "CORE_DATA=$3" >> "$commander_config" 2>&1
    echo "CORE_CONFIG=$4" >> "$commander_config" 2>&1
    echo "CORE_TOKEN=$5" >> "$commander_config" 2>&1
    echo "CORE_NETWORK=$6" >> "$commander_config" 2>&1
    echo "EXPLORER_REPO=$7" >> "$commander_config" 2>&1
    echo "EXPLORER_DIR=$8" >> "$commander_config" 2>&1

    . "$commander_config"

    success "The commander configuration has been updated."
}
